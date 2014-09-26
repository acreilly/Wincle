module SessionsHelper

 def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session[:user_id] = nil
  end

  class Sess


  def set_sessions(user, info)
    binding.pry
    session[:user_id] = user.id
    session[:picture_url] = info["picture_url"]
    session[:headline] = info["headline"]
    session[:public_profile_url] = info["public-profile-url"]
  end
  end

end