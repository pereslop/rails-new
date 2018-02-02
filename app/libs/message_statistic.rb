class MessageStatistic
  attr_accessor :user, :day

  def initialize(user, day)
    @day = day
    @user = user
  end

  def messages(scope)
    @user.conversations.inject([]) { |memo, conversation| memo += user.public_send(scope, conversation, day) }
  end
end