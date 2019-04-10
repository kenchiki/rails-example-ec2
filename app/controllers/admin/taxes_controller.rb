class Admin::TaxesController < ApplicationController
  def new
    @tax = Tax.order(id: :desc).first_or_initialize
  end

  def create
    @tax = Tax.new(tax_params)

    if @tax.save
      redirect_to new_admin_tax_path, notice: 'Tax was successfully created.'
    else
      render :new
    end
  end

  private

  def tax_params
    params.require(:tax).permit(:rate)
  end
end
