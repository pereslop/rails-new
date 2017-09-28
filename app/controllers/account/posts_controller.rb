class Account::PostsController < ApplicationController

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
  end


  private

  def post_params
    params.require(:post).permit(:content, :picture)
  end

  def collection
    current_user.posts.ordered
  end

  def resource
    collection.find(params[:id])
  end
end
