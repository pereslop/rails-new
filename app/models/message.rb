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
  belongs_to :sender, class_name: User
  belongs_to :recipient, class_name: User

  validates :body, presence: true, length: { maximum: 250 }
  validate :sender_can_not_be_recipient

  def sender_can_not_be_recipient
    if sender_id == recipient_id
      errors.add(:base, 'you can not send message to yourself')
    end
  end

  scope :all_for_user, ->(user) do
    where(sender_id: user.id).or(Message.where(recipient_id: user.id))
  end
  scope :sent, ->(user) { where(sender_id: user.id)}
  scope :received, ->(user) { where(recipient_id: user.id) }
  scope :ordered, ->{ order(created_at: :desc) }
  scope :between_users, ->(sender, recipient) do
    where('(sender_id = ? AND recipient_id = ?) OR (recipient_id = ? AND sender_id = ?)', sender.id, recipient.id, sender.id, recipient.id)
  end
end
