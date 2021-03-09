class Customers::CartController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :set_item, only: [:update]

  def update
    @cart.add_item(@item.id)
    session[:cart] = @cart.contents
    quantity = @cart.count_of(@item.id)

    flash[:notice] = "You now have #{pluralize(quantity, "#{@item.name}")} in your cart."
    redirect_to merchant_items_path(params[:merchant_id])
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
