class Merchants::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :set_merchant, only: [:index, :new, :create]

  def index
    @cart = Cart.new(session[:cart])
  end

  def new
    @item = Item.new
  end

  def create
    @item = @merchant.items.new(item_params)
    if @item.save
      flash[:notice] = "#{@item.name} Created"
      redirect_to merchant_items_path(@merchant)
    else
      flash[:notice] = "Required Information Missing"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:status]
      button_logic
    elsif @item.update(item_params) && !params[:status]
      flash[:notice] = "Item Succesfully Updated"
      redirect_to merchant_item_path(@item.merchant, @item)
    elsif !@item.update(item_params)
      flash[:notice] = "Required Information Missing"
      redirect_to edit_merchant_item_path(@item.merchant, @item)
    end
  end

  private

  def button_logic
    if params[:status] == "disable"
      @item.disable_item
      flash[:notice] = "#{@item.name} Disabled"
      redirect_to merchant_items_path(@item.merchant)
    else
      @item.enable_item
      flash[:notice] = "#{@item.name} Enabled"
      redirect_to merchant_items_path(@item.merchant)
    end
  end

  def item_params
    params.permit(:name, :description, :unit_price)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
