class User < ActiveRecord::Base
  has_one :employer
  has_one :employee
  has_secure_password
  validates_confirmation_of :password
end
