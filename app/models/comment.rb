# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_type :string
#  commentable_id   :integer
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  scope :ordered, -> { order(created_at: :desc) }
  scope :last_week, -> { where('created_at >= ?', 1.week.ago) }

  validates :content, presence: true

  def self.count_per_day(day)
    self.where(updated_at: day.all_day).count
  end
end
