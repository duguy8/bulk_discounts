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
    if @merchant.update(merchant_params)
      flash[:notice] = "Merchant Updated Successfully"
      redirect_to admin_merchant_path(@merchant)
    elsif !@merchant.update(merchant_params)
      flash[:notice] = "Required Information Missing"
      render :edit
    end
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
