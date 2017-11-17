class Account::UsersController < AccountController
  def index
    @users = collection
  end

  def show
    @user = resource
    @posts = @user.posts.ordered.page(params[:page]).per(24)
    @post = @user.posts.new
    @followees = followees
    @followers = followers
  end

  def follow
    current_user.follow!(resource)
  end

  def unfollow
    current_user.unfollow!(resource)
  end
  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def collection
    User.ordered
  end

  def resource
    collection.find(params[:id])
  end

  def followers
    resource.followers(User)
  end

  def followees
    resource.followables(User)
  end

end
