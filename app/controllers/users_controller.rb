class UsersController < ApplicationController
  include SessionsHelper

  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to edit_user_path
    else
      redirect_to :back
    end
  end

  def edit

  end

  def update

  end

  def show

  end

  def delete

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
