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

  def destroy
    session[:user_id] = nil
    # remember to clear ALL sessions
    redirect_to root_path
  end

end