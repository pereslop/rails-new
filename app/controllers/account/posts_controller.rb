class Account::PostsController < ApplicationController
  def index
    @posts = collection.page(params[:page]).per(24)
  end

  def create
    @post = current_user.posts.build(post_params)
    flash[:danger] = "Post #{@post.errors.messages}" unless @post.save
    redirect_to account_user_path(current_user)
  end

  def show
    @post = resource
    @comments = Comment.where(post_id: @post).ordered
  end

  def destroy
    @user = resource
    @user.destroy
    redirect_to account_user_path(current_user)
  end

  def toggle_like
    @post = resource
    current_user.toggle_like!(@post)
    @post.reload

    respond_to do |format|
      format.js { render 'account/posts/update_button' }
    end
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
