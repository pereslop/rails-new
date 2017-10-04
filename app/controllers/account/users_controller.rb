class Account::UsersController < AccountController
  def index
    @users = collection
  end

  def show
    @user = resource
    @posts = @user.posts.ordered.page(params[:page]).per(24)
    @post = @user.posts.new
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def collection
    User.ordered
  end

  def resource
    collection.find(params[:id])
  end

end
