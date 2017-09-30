class Account::PostsController < ApplicationController
  def index
    @posts = collection
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to account_user_path(current_user)
    else
      # redirect_to
    end
  end

  def show
    @post = resource
  end

  def destroy
    @user = resource
    @user.destroy
    redirect_to account_user_path(current_user)
  end

  def toggle_like
    @post = resource
    current_user.toggle_like!(@post)
    redirect_back(fallback_location: account_post_path(@post))
  end
  private

  def post_params
    params.require(:post).permit(:content, :picture, :likees_count)
  end

  def collection
    Post.all.ordered
  end

  def resource
    collection.find(params[:id])
  end
end
