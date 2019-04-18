class Admin::TaxesController < Admin::AdministratorController
  def new
    @tax = Tax.order(id: :desc).first_or_initialize
  end

  def create
    @tax = Tax.new(tax_params)

    if @tax.save
      redirect_to new_admin_tax_path, notice: '税率を編集しました'
    else
      render :new
    end
  end

  private

  def tax_params
    params.require(:tax).permit(:rate)
  end
end
