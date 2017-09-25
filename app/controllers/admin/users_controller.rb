class Admin::UsersController < ApplicationController
  before_action :admin?

  def index
    @users = User.ordered.paginate(page: params[:page])
  end

  def new
    @user = collection.new
  end

  def create
    @user = collection.new(user_params)

    if @user.save
      redirect_to admin_user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = resource
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
    parameters = params.require(:user).permit(:username, :role, :email, :password)

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