class Customers::UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def new
  end

  def show
  end

  def create
    user = User.create(user_params)
    flash[:notice] = "Welcome, #{user.username}!"
    session[:user_id] = user.id
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(session[:user_id])
  end

  def user_params
    params.permit(:username, :password)
  end
end
