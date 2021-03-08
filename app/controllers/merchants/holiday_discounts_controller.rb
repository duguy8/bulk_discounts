class Merchants::HolidayDiscountsController < ApplicationController
  before_action :set_discount, only: [:new]
  before_action :set_merchant, only: [:new]
  before_action :set_holiday, only: [:new]

  def new
  end

  private

  def set_discount
    @discount = Discount.new
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def set_holiday
    @holiday = params[:format]
  end
end
