class Account::Posts::CommentsController < ApplicationController
  before_action :find_post
  before_action :resource, only: [:destroy, :edit]

  def index
    @posts = find_post
    @comments = @post.comments.page(params[:page]).per(10)
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comments = @post.comments.page(params[:page]).per(10)
    if @comment.save
      respond_to do |format|
        format.js
      end
    end
  end

  def new
    @post = find_post
    respond_to do |format|
     format.js
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
    @comments = @post.comments.page(params[:page]).per(10)
    if @comment.update(comment_params)
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
   @comment.destroy
   @comments = @post.comments.page(params[:page]).per(10)
   respond_to do |format|
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
