class My::OrdersController < ApplicationController
  before_action :set_order, only: %i[show]
  before_action :require_delivery_info, only: %i[new create]

  protect_from_forgery except: :ipn
  skip_before_action :basic_authentication, :authenticate_user!, only: :ipn
  ORDER_TOTAL = 1000

  def index
    @orders = current_user.orders.order(id: :desc).page(params[:page])
  end

  def show
  end

  def setup_purchase
    response = paypal_gateway.setup_purchase(
      ORDER_TOTAL,
      return_url: purchase_my_orders_url,
      cancel_return_url: cancel_my_orders_url,
      ip: request.remote_ip,
      items: [
        {
          name: "a subject", # 件名
          quantity: 1, # 数量
          amount: ORDER_TOTAL # 支払い金額
        }]
    )

    if response.success?
      redirect_to paypal_gateway.redirect_url_for(response.token)
    else
      raise 'paypal側でエラー発生'
    end
  end

  def purchase
    @details = paypal_gateway.details_for(params[:token])

    # 購入処理
    response = paypal_gateway.purchase(
      ORDER_TOTAL,
      ip: request.remote_ip,
      token: params[:token],
      payer_id: params[:PayerID],
      notify_url: ipn_my_orders_url # IPNを受け取るURL
    # localhostだとPayPalからアクセスできないので
    # 開発時にはngrokなどを使う
    )

    unless response.success?
      raise '決済できませんでした'
    end

    @order = current_user.orders.build
    @order.delivery_date = current_cart.delivery_date
    @order.delivery_time_detail = current_cart.delivery_time_detail
    @order.cart = current_cart

    @order.save!
    new_cart
    redirect_to [:my, @order], notice: '注文が完了しました'
  end

  # TODO:response.acknowledgeで止まってしまう問題
  # IPNを受け取ったときの処理
  def ipn
    response = OffsitePayments::Integrations::Paypal::Notification.new(request.raw_post).extend(PaypalNotification)

    # 対象となる支払いをVERIFYしている
    unless response.acknowledge
      logger.error 'invalid ipn'
      render nothing: true, status: :bad_request
    end

    # 支払い金額が意図した金額になっているのか念のため確認
    if response.completed?(ORDER_TOTAL)
      logger.info 'completed'
    elsif response.refunded?(ORDER_TOTAL)
      logger.info 'refunded'
    else
      logger.error 'failed'
    end

    # HTTPステータス204を返すとPayPal側で決済処理完了として扱われる
    render nothing: true
  end

  def gateways
  end

  def cancel
  end

  private

  def paypal_gateway
    ActiveMerchant::Billing::PaypalExpressGateway.new(
      login: ENV.fetch('PAYPAL_LOGIN'),
      password: ENV.fetch('PAYPAL_PASSWORD'),
      signature: ENV.fetch('PAYPAL_SIGNATURE'),
    )
  end

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def require_delivery_info
    unless current_user.last_shipping_address
      redirect_to new_my_shipping_address_path, alert: '配送情報を入力してください'
    end
  end


end
module PaypalNotification
  def completed?(amount)
    complete? && amount == gross.to_i
  end

  def refunded?(amount)
    status == 'Refunded' && (0 - amount) == gross.to_i
  end
end