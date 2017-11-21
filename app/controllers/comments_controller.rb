class CommentsController < ApplicationController

  def index
    @comments = @commentable.comments.includes(:user).ordered.page(params[:page]).per(5)
  end

  def new
    @comment = @commentable.comments.new

    render 'account/comments/new'
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render 'account/comments/create'
    end
  end

  def edit
    @comment = resource

    render 'account/comments/edit'
  end

  def update
    @comment = resource
    if @comment.update(comment_params)
      @comment.reload
        render 'account/comments/update'
    end
  end

  def destroy
   @comment = resource
   @comment.destroy

   render 'account/comments/destroy'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def resource
    @comment = @commentable.comments.ordered.find(params[:id])
  end
end
