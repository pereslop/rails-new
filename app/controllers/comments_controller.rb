class CommentsController < ApplicationController

  def index
    @comments = @commentable.comments.page(params[:page]).per(10)
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comments = @commentable.comments.page(params[:page]).per(10)
    if @comment.save
      respond_to do |format|
        format.js
      end
    end
  end

  def edit
    @comment = resource
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment = resource
    @comments = @commentable.comments.page(params[:page]).per(10)
    if @comment.update(comment_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
   @comment = resource
   @comment.destroy
   @comments = @commentable.comments.page(params[:page]).per(10)
   respond_to do |format|
     format.js
   end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def resource
    @comment = @commentable.comments.find(params[:id])
  end
end
