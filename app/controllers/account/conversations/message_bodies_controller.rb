class Account::Conversations::MessageBodiesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @message_body = MessageBody.new(message_body_params)
    @message.user_id = @message_body.user_id = current_user.id
    if @message.save
      @message_body.message_id = @message.id
      if @message_body.save
        current_user.user_conversations.read_conversation(conversation)
        redirect_to chat_account_conversation_path(conversation), remote:true
      else
        @message.destroy
        empty_responce
      end
    else
      empty_responce
    end
  end

  private
  def empty_responce
    render body: nil
  end


  def conversation
    Conversation.find(@message.conversation_id)
  end

  def message_params
    params.require(:message_body).permit(:conversation_id)
  end

  def message_body_params
    params.require(:message_body).permit(:body, :conversation_id)
  end
end
