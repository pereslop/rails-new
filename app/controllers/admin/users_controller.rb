class Admin::UsersController < AdminController
  def index
    @users = collection.page(params[:page]).per(LIST_OF_ENTITIES)
  end

  def show
    @user = resource
    @last_comments = @user.comments.last_week.ordered
  end

  def edit
    @user = resource
  end

  def update
    @user = resource
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = resource
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    parameters = params.require(:user).permit(:username, :role)

    if parameters[:password].nil? || parameters[:password].empty?
      parameters.delete(:password)
    end

    parameters
  end

  def collection
    User.all
  end

  def resource
    collection.find(params[:id])
  end
end
