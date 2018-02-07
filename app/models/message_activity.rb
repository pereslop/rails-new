class MessageActivity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: Integer
  field :read_messages_count, type: Integer
  field :unread_messages_count, type: Integer

  validates_presence_of :user_id, :read_messages_count, :unread_messages_count
  validate :unique_for_one_day
  scope :for_user, ->(user) { where(user_id: user.id) }
  scope :created_after, ->(start_time) { where(:created_at.gte => start_time) }
  scope :for_whole_day, ->(day) { where(created_at: day.beginning_of_day..day.end_of_day) }
  private

  def unique_for_one_day
    if MessageActivity.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day, user_id: self.user_id).present?
      errors.add(:uniqueness, 'you can\'t save two identical records for one user in one day')
    end
  end
end
