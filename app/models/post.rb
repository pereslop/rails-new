# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :user

  scope :ordered, -> { order(created_at: :desc)}
end

# def @post.toggle_like(user)
#   like = self.likes.find_by(:user_id, user.id)
#
#   if like.present?
#     like.destroy
#   else
#     self.likes.create(user: user)
#   end
# end
#
# controller
#
# def toogle_like
#   @post = Post.find(params[:id])
#
#   redirect_back(fallback_location: post_path(post))
# end