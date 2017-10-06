class Account::CommentsController < ApplicationController
 before_action :find_post
 before_action :resource, only: [:destroy, :edit, :update]

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    flash[:danger] = "Comment #{@comment.errors.messages}" unless @comment.save
    redirect_to account_post_path(find_post)
  end

   def edit
      @comment = resource
   end

  def update
   @comment = resource
    if @comment.update(comment_params)
      redirect_to account_post_path(find_post)
    else
      render :edit
    end
  end

  def destroy
   @comment.destroy
   respond_to do |format|
     format.html do
    flash[:success] = 'Comment deleted.'
    redirect_to account_post_path(@post)
     end
     format.js
   end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def resource
    @comment = @post.comments.find(params[:id])
  end
end