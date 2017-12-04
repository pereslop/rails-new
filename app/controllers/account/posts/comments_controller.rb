class Account::Posts::CommentsController < ::CommentsController
  before_action :set_commentable

  def new
    @comment = @commentable.comments.new

    render 'account/posts/comments/new'
  end

  def create
    @comments = @commentable.comments.ordered.page(params[:page]).per(5)
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    render 'account/posts/comments/create' if @comment.save
  end

  private

  def set_commentable
    @commentable = Post.find(params[:post_id])
  end
end