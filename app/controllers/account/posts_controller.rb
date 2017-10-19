class Account::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @posts = collection.page(params[:page]).per(20)
  end

  def create
    @post = current_user.posts.build(post_params)
    flash[:danger] = "Post #{@post.errors.messages}" unless @post.save
    redirect_to account_user_path(current_user)
  end

  def show
    @post = resource
    @comments = @post.comments.ordered
    respond_to do |format|
      format.js { render 'account/posts/update_gallery' }
    end
  end

  def edit
    @post = resource
    respond_to do |format|
      format.js
    end
  end

  def update
    @post = resource
    if @post.update(post_update_params)
      respond_to do |format|
        format.js { render 'account/posts/update_gallery' }
      end
    else
      flash[:alert] = 'Updating canceled'
    end
  end


  def destroy
    @post = resource
    @post.next ? @post_for_show = @post.next : @post_for_show = @post.prev
    @posts = collection.page(params[:page]).per(24)
    @post.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Post deleted.'
      end
      format.js { render 'account/posts/destroy' }
    end
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

  def post_update_params
    params.require(:post).permit(:content)
  end

  def collection
    Post.all.ordered
  end

  def resource
    collection.find(params[:id])
  end
end
