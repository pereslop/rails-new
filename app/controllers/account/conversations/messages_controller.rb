class Account::Conversations::MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if @message.save
      redirect_to chat_account_conversation_path(Conversation.find(@message.conversation_id)), remote:true
    else
      render body: nil
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :conversation_id)
  end
end
