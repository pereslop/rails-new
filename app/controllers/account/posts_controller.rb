class Account::PostsController < ApplicationController
  def index
    @posts = collection.page(params[:page]).per(24)
  end

  def create
    @post = current_user.posts.create(post_params)
    flash[:danger] = "Post #{@post.errors.messages}" unless @post.save
    redirect_to account_user_path(current_user)
  end

  def show
    @post = resource
    @comments = @post.comments.ordered
  end

  def destroy
    @post = resource
    @post.destroy
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
    params.require(:post).permit(:content, :picture)
  end

  def collection
    Post.all.ordered
  end

  def resource
    collection.find(params[:id])
  end
end
