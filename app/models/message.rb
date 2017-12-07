# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  body         :text
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id

  validates :body, presence: true

  scope :all_for_user, ->(user) do
    where(sender_id: user.id).or(Message.where(recipient_id: user.id))
  end
  scope :sent, ->(user) { where(sender_id: user.id)}
  scope :received, ->(user) { where(recipient_id: user.id) }
  scope :ordered, ->{ order(created_at: :desc) }
end
