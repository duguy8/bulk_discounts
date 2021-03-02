class Admin::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :edit, :update]

  def index
    @merchants = Merchant.all
  end

  def show
  end

  def edit
  end

  def update
    if params[:status]
      button_logic
    elsif @merchant.update(merchant_params) && !params[:status]
      flash[:notice] = "Merchant Updated Successfully"
      redirect_to admin_merchant_path(@merchant)
    elsif !@merchant.update(merchant_params)
      flash[:notice] = "Required Information Missing"
      render :edit
    end
  end

  private

  def button_logic
    if params[:status] == "enable"
      @merchant.update(status: true)
      flash[:notice] = "#{@merchant.name} Enabled"
      redirect_to admin_merchants_path
    else
      @merchant.update(status: false)
      flash[:notice] = "#{@merchant.name} Disabled"
      redirect_to admin_merchants_path
    end
  end

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
