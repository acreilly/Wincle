class SessionsController < ApplicationController

  def create
    binding.pry
    user = User.find_by_email(params[:users][:email])
    binding.pry
    if user && user.authenticate(params[:users][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end