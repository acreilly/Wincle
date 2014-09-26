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
    @user = user.find(params[:id])
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
    binding.pry
    linkedin = LinkedinHelper::ToLinkedin.new
    access_token = linkedin.get_access_token(params[:code])
    binding.pry
    api = LinkedIn::API.new(access_token)
    user_profile = api.profile
    user_info = api.profile(fields: ['id', 'email-address', 'first-name', 'last-name', 'headline', 'location', 'industry', 'picture-url', 'public-profile-url'])
    session[:user_id] = user_info["id"]
    session[:email] = user_info["email-address"]
    session[:first_name] = user_info["first_name"]
    session[:last_name] = user_info["last_name"]
    session[:industry] = user_info["industry"]
    session[:picture_url] = user_info["picture_url"]
    session[:headline] = user_info["headline"]
    session[:public_profile_url] = user_info["public-profile-url"]

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:user_type, :first_name, :last_name, :email, :password, :password_confirmation)
  end
end
