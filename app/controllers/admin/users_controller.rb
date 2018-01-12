class Admin::UsersController < AdminController
  def index
    @users = collection.page(params[:page]).per(LIST_OF_ENTITIES)
  end

  def show
    @user = resource

    last_comments

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

  def statistic
    last_comments

    UserMailer.statistic(resource, @last_comments).deliver
    render body: nil
  end

  private
  def last_comments
    @last_comments = resource.comments.last_week.ordered
  end

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
