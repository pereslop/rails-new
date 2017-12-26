class Account::MessagesController < ApplicationController

  def create
    @message = current_user.messages.build(message_params)
    @message.conversatio <<  Conversation.find(params[:converstaion_id]))
    byebug
    if @message.save
      render
    else
      render body: nil
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :recipient_id)
  end
end
