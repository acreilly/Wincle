class EmployeesController < ApplicationController
  include SessionsHelper

  def index

  end

  def edit
    @employee = current_user.employee
    binding.pry
  end

  def update
    employee = Employee.find_by_user_id(current_user.id)
    employee.update_attributes(
      industry: params[:employee][:industry],
      job_title: params[:employee][:job_title],
      location: params[:employee][:location], bio: params[:employee][:bio])
    redirect_to posts_path
  end

  def show

  end

  def delete

  end

  private

  # def employee_params
  #   params.require(:employee).permit()
  # end
end
