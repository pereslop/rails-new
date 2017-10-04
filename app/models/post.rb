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

  scope :ordered, -> { order(created_at: :desc) }

  acts_as_likeable

  mount_uploader :picture, PictureUploader
end
