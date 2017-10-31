class Account::Users::PostsController < Account::PostsController

  def show
    @post = resource
    @posts = @post.user.posts.ordered
    respond_to do |format|
      format.js { render 'account/users/posts/update_gallery' }
    end
  end

  def destroy
    @post = resource
    @post_for_show = @post.next ? @post.next : @post.prev
    @posts = collection.page(params[:page]).per(24)
    @post.destroy
    respond_to do |format|
      format.js { render 'account/posts/destroy' }
    end
  end

  private


  def post_update_params
    params.require(:post).permit(:content)
  end

  def collection
    @user = User.find(params[:id])
    @posts = @user.posts.ordered
  end

  def resource
    Post.find(params[:id])
  end
end
