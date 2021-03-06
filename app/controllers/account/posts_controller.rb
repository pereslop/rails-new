class Account::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @posts = collection.page(params[:page])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash.now[:danger] = "Post #{@post.errors.messages}"
    else
      flash[:danger] = @post.errors.messages
    end
      redirect_to account_user_path(current_user)
  end

  def show
    @post = resource
    @posts = collection

    render 'account/posts/update_gallery'
  end

  def edit
    @post = resource
  end

  def update
    @post = resource

    if @post.update(post_update_params)
      render 'account/posts/update'
    else
      flash[:alert] = 'Updating canceled'
    end
  end


  def destroy
    @post = resource
    @post_for_show = @post.next ? @post.next : @post.prev
    @posts = collection.page(params[:page]).per(LIST_OF_ENTITIES)
    @post.destroy
  end

  def toggle_like
    @post = resource
    current_user.toggle_like!(@post)
    @post.reload

    render :update_button
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