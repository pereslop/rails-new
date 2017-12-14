class Account::UsersController < AccountController
  def index
    @users = @search.result.page(params[:page]).per(24)
  end

  def show
    @user = resource
    @posts = @user.posts.ordered.page(params[:page]).per(24)
    @post = @posts.new
    @followees = user_followees
    @followers = user_followers
  end

  def followers
    @users = user_followers

    render :update_follow_modal
  end

  def followees
    @users = user_followees

     render :update_follow_modal
  end

  def follow
    @user = resource
    current_user.follow!(@user)
  end

  def unfollow
    @user = resource
    current_user.unfollow!(@user)

    render :follow
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

  def user_followers
    resource.followers(User)
  end

  def user_followees
    resource.followables(User)
  end
end
