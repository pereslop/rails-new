class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to show_path
    else
      redirect_to show_path
    end
  end

  def destroy
  end


  private

  def post_params
    params.require(:post).permit(:content)
  end

  def collection
    current_user.posts.ordered
  end

  def resource
    collection.find(params[:id])
  end
end
