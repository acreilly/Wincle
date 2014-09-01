class EmployersController < ApplicationController
  include SessionsHelper

  def index

  end

  def edit
    @employer = current_user.employer
  end

  def update
    employer = Employer.find_by_user_id(current_user.id)
    employer.update_attributes(
      industry: params[:employer][:industry],
      company: params[:employer][:company])
    redirect_to root_path
  end

  def show

  end

  def delete

  end

  private

  # def employer_params
  #   params.require(:employer).permit()
  # end
end
