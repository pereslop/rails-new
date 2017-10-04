# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  content      :text
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  picture      :string
#  likers_count :integer          default(0)
#  likees_count :integer          default(0)
#

class Post < ApplicationRecord
  belongs_to :user

  scope :ordered, -> { order(created_at: :desc) }

  acts_as_likeable

  mount_uploader :picture, PictureUploader

  validates :picture, presence: true
end
