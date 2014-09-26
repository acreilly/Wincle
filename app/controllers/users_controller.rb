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
client = OAuth2::Client.new( "#{ENV['LINKEDIN_API_KEY']}", "#{ENV['LINKEDIN_API_SECRET']}", :site => 'https://linkedin.com')

client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback')
    redirect_to "#{linkedin.login}"
  end

  def linkedin_callback
    linkedin = LinkedinHelper::ToLinkedin.new

    access_token = linkedin.get_access_token(params[:code])


    if access_token.nil?
      redirect_to root_path
    else

      user_info = linkedin.get_user_info(access_token)
binding.pry
      user = User.find(linkedin_id: user_info["id"])
      binding.pry
      if user.id == nil
        create_user(user_info)
      else
        set_sessions(user, user_info)
      end
      redirect_to user_path(session[:user_id])
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_type, :first_name, :last_name, :email, :password, :password_confirmation)
  end
end
