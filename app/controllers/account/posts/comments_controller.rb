class Account::Posts::CommentsController < ::CommentsController
  before_action :set_commentable

  def new
    @comment = @commentable.comments.new
    respond_to do |format|
      format.js
    end
  end
  private

  def set_commentable
    @commentable = Post.find(params[:post_id])
  end

end