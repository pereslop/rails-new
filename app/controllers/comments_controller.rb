class CommentsController < ApplicationController

  def index
    @comments = @commentable.comments.includes(:user).ordered.page(params[:page]).per(5)
  end

  def new
    @comment = @commentable.comments.new
    respond_to do |format|
      format.js { render 'account/comments/new' }
    end
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.js { render 'account/comments/create'}
      end
    end
  end

  def edit
    @comment = resource
    respond_to do |format|
      format.js { render 'account/comments/edit' }
    end
  end

  def update
    @comment = resource
    if @comment.update(comment_params)
      respond_to do |format|
        format.js { render 'account/comments/update' }
      end
    end
  end

  def destroy
   @comment = resource
   @comment.destroy
   respond_to do |format|
     format.js { render 'account/comments/destroy' }
   end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def resource
    @comment = @commentable.comments.ordered.find(params[:id])
  end
end
