class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  scope :ordered, -> { order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 120}
end
