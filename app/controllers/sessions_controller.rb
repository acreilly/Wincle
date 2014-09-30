class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:users][:email])
    if user && user.authenticate(params[:users][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  def logout
    logout
    redirect_to root_path
  end

end