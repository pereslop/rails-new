class Account::MessagesController < ApplicationController

  def create
    @message = current_user.messages.build(message_params)
    # @message.conversation <<  Conversation.find(params[:converstaion_id])
    if @message.save
      render 'account/conversations/chat'
    else
      render body: nil
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :conversation_id)
  end
end
