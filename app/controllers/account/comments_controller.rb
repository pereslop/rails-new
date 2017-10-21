class Account::CommentsController < ApplicationController
  before_action :find_post
  before_action :resource, only: [:destroy, :edit]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.js
      end
    end
    flash[:danger] = "Comment #{@comment.errors.messages}" unless @comment.save
  end

  def new
    @post = find_post
    respond_to do |format|
     format.js { render 'account/comments/new'}
    end
  end

  def edit
    @comment = resource
    respond_to do |format|
      format.js { render 'account/comments/edit'}
    end
  end

  def update
   @comment = resource
    if @comment.update(comment_params)
      respond_to do |format|
        flash[:success] = 'Comment updated'
        format.js
      end
    else
      flash[:alert] = 'Updating canceled'
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