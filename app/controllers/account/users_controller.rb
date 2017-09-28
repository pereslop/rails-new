class Account::UsersController < AccountController
  def index
    @users = User.ordered
  end

  def show
    @user = resource
    @posts = resource.posts
  end

  def accounts

  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def collection
    User.all
  end

  def resource
    collection.find(params[:id])
  end

end