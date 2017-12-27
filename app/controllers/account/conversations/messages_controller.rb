class Account::Conversations::MessagesController < ApplicationController

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to chat_account_conversation_path(@message.conversation), remote:true
    else
      render body: nil
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :conversation_id)
  end
end
