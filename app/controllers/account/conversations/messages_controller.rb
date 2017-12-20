class Account::Conversations::MessagesController < ApplicationController

  def create
    @message = current_user.sent_messages.build(message_params)
    if @message.save
      puts ''
    else
      render body: nil
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :recipient_id)
  end
end
