class Account::Users::PostsController < Account::PostsController

  def show
    @post_for_show = resource
    @posts = @post_for_show.user.posts.ordered
    respond_to do |format|
      format.js { render 'account/users/posts/update_gallery' }
    end
  end

  def destroy
    @post = resource
    @posts = collection.ordered
    @post_for_show = @posts.prev_for(@post) ? @posts.prev_for(@post) : @posts.next_for(@post)
    @post.destroy
    respond_to do |format|
      format.js { render 'account/users/posts/update_gallery' }
    end
  end

  private

  def post_update_params
    params.require(:post).permit(:content)
  end

  def collection
    @user = User.find(params[:user_id])
    @posts = @user.posts.ordered
  end

  def resource
    Post.find(params[:id])
  end
end
