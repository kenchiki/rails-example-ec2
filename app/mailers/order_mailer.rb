class OrderMailer < ApplicationMailer
  def user_thanks
    @order = params[:order]
    mail(to: @order.user.email, subject: '【さくらマーケット】ご注文ありがとうございます')
  end

  def notify_admin
    @order = params[:order]
    mail(to: User.where(admin: true).pluck(:email), subject: "【さくらマーケット】注文がありました(ID:#{@order.id})")
  end
end
