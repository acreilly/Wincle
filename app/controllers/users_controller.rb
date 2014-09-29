class UsersController < ApplicationController
  include SessionsHelper
  include UsersHelper

  def index
    # Maybe use to search specific users?
    # Maybe dont need at all
  end


# MIGHT NOT NEED THIS
  def new
    @user = User.new
  end


# MIGHT NOT NEED CREATE ANYMORE SINCE ONLY USING LINKEDIN
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
    # ADD EDIT USER SECTION
    info = JobInfo::Client.new
    @industry = info.get_industries
    if current_user.user_type == "employee"
      @employee = current_user.employee
    else
      @employer = current_user.employer
    end
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(user_type: params["user"]["user_type"])
    redirect_to user_path(user)
  end

  def show
    @user = User.find(params[:id])
  end

  def home
    @posts = Post.all
  end

  def destroy
    logout
    redirect_to root_path
  end

  def login
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
        user = linkedin.create_user(user_info)
        if user.save
          set_sessions(user, user_info)
        else
          redirect_to root_path
        end
      else
        set_sessions(user, user_info)
      end
      redirect_to user_path(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_type, :first_name, :last_name, :email, :password, :password_confirmation)
  end
end
