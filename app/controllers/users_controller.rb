class UsersController < ApplicationController
  include SessionsHelper
  include UsersHelper

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      if @user.user_type == "employee"
        Employee.create(user_id: @user.id)
      else
        Employer.create(user_id: @user.id)
      end
      redirect_to edit_user_path(@user)
    else
      redirect_to :back
    end
  end

  def edit
    info = JobInfo::Client.new
    @industry = info.get_industries
    if current_user.user_type == "employee"
      @employee = current_user.employee
    else
      @employer = current_user.employer
    end
  end

  def update
  end

  def show
    @user = User.find(params[:id])
  end

  def home
    @posts = Post.all
  end

  def delete
  end

  def login
    linkedin = LinkedinHelper::ToLinkedin.new
    LinkedIn.configure do |config|
      config.client_id     = ENV["LINKEDIN_API_KEY"]
      config.client_secret = ENV["LINKEDIN_SECRET_KEY"]
      config.redirect_uri  = "http://localhost:3000/linkedin_callback"
    end
    oauth = LinkedIn::OAuth2.new

    url = oauth.auth_code_url
    redirect_to "#{url}"
  end

  def linkedin_callback
    oauth = LinkedIn::OAuth2.new
    code = params[:code]
    access_token = oauth.get_access_token(code)

    linkedin = LinkedinHelper::ToLinkedin.new
    if access_token.nil?
      redirect_to root_path
    else

      user_info = linkedin.get_user_info(access_token)
      linkedin_id = user_info["id"]
      user = User.find_by(linkedin_id: linkedin_id)
      if user == nil
        linkedin.create_user(user_info)
      else
        session[:user_id] = user.id
        session[:picture_url] = user_info["picture_url"]
        session[:headline] = user_info["headline"]
        session[:public_profile_url] = user_info["public-profile-url"]
      end
      redirect_to user_path(session[:user_id])
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_type, :first_name, :last_name, :email, :password, :password_confirmation)
  end
end
