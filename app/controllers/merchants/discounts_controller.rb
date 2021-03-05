class Merchants::DiscountsController < ApplicationController
  before_action :set_merchant, only: [:index, :show, :create, :destroy]
  before_action :set_discount, only: [:show, :edit, :update, :destroy]

  def index
    @holidays = NagerService.upcoming_holidays
  end

  def show
  end

  def new
    @discount = Discount.new
  end

  def create
    @discount = @merchant.discounts.new(discount_params)
    if @discount.save
      flash[:notice] = "#{@discount.name} Created Succesfully"
      redirect_to merchant_discounts_path(@merchant)
    else
      flash[:notice] = "#{@discount.errors.full_messages.pop}"
      render :new
    end
  end

  def edit
  end

  def update
    if @discount.update(discount_params)
      flash[:notice] = "#{@discount.name} Updated Succesfully"
      redirect_to merchant_discount_path(@discount.merchant, @discount)
    else
      flash[:notice] = "#{@discount.errors.full_messages.pop}"
      render :edit
    end
  end

  def destroy
    @discount.destroy
    flash[:notice] = "#{@discount.name} Deleted Succesfully"
    redirect_to merchant_discounts_path(@merchant)
  end

  private

  def discount_params
    params.require(:discount).permit(:name, :quantity_threshold, :percentage_discount)
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def set_discount
    @discount = Discount.find(params[:id])
  end
end
