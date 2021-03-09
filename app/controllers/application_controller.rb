class ApplicationController < ActionController::Base
  before_action :cart

  def cart
    @cart ||= Cart.new(session[:cart])
  end
end
