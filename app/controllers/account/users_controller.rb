class Account::UsersController < AccountController
  def index
    @user = current_user
    @posts = @user.posts.paginate(page: params[:page])
    @post = @user.posts.build if @user
  end

  def show
  end
end