class Account::Conversations::MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if @message.save
      current_user.user_conversations.read_conversation(conversation)
      redirect_to chat_account_conversation_path(conversation), remote:true
    else
      render body: nil
    end
  end

  private

  def conversation
    Conversation.find(@message.conversation_id)
  end

  def message_params
    params.require(:message).permit(:body, :conversation_id)
  end
end
