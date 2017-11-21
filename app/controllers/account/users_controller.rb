class Account::UsersController < AccountController
  def index
    @users = collection
  end

  def show
    @user = resource
    @posts = @user.posts.ordered.page(params[:page]).per(24)
    @post = @posts.new
    @followees = get_followees
    @followers = get_followers
  end

  def followers
    @users = get_followers

    render 'account/users/update_follow_modal'
  end

  def followees
    @users = get_followees

     render 'account/users/update_follow_modal'
  end

  def follow
    @user = resource
    current_user.follow!(@user)

    render 'account/users/follow'
  end

  def unfollow
    @user = resource
    current_user.unfollow!(@user)

    render 'account/users/follow'
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

  def get_followers
    resource.followers(User)
  end

  def get_followees
    resource.followables(User)
  end

end
