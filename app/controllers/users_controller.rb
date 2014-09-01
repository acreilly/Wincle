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
    if current_user.user_type == "employee"
      @employee = current_user.employee
    else
      @employer = current_user.employer
    end
  end

  def update
  end

  def show

  end

  def delete

  end

  private

  def user_params
    params.require(:user).permit(:user_type, :first_name, :last_name, :telephone, :email, :password, :password_confirmation)
  end
end
