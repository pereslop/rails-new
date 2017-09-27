class HomeController < ApplicationController
  def show
    @user = current_user
    @posts = @user.posts.paginate(page: params[:page])
    @post = @user.posts.build if @user
  end

  private

  def collection
    User.all
  end

  def resource
  end
end
