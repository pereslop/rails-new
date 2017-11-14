class Account::Posts::CommentsController < ::CommentsController
  before_action :set_commentable

  def new
    @comment = @commentable.comments.new

    respond_to do |format|
      format.js { render 'account/posts/comments/new' }
    end
  end

  def create
    @comments = @commentable.comments.ordered.page(params[:page]).per(5)
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.js { render 'account/posts/comments/create' }
      end
    end
  end

  private

  def set_commentable
    @commentable = Post.find(params[:post_id])
  end

end