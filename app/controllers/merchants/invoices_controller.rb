class Merchants::InvoicesController < ApplicationController
  before_action :set_merchant, only: [:show, :index]

  def index
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
