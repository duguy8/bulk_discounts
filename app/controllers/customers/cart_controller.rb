class Customers::CartController < ApplicationController
  before_action :set_item, only: [:update]

  def update
    flash[:notice] = "You now have 1 #{@item.name} in your cart."
    redirect_to merchant_items_path(params[:merchant_id])
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
