class User < ActiveRecord::Base
  has_one :employer
  has_one :employee
  has_secure_password
  validates_confirmation_of :password

  def create_user(info)
    user = User.new(email: info["email-address"], first_name: info["first_name"], last_name: info["last_name"], industry: info["industry"], linkedin_id: info["id"])
    if user.save
      set_sessions(user, info)
      redirect_to user_path(user)
    else
      redirect_to root_path
    end
  end

end
