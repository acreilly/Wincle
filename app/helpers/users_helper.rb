module UsersHelper
  def create_user(arguments)
    user = User.new(arguments)
    if user.save
      redirect_to edit_user_path(user)
    else
      redirect_to root_path
    end
  end
end
