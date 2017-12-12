class Account::MessagesController < ApplicationController

  def index
    @companion = current_user.companions.first
    redirect_to chat_account_message_path(@companion)
  end

  def chat
    @companion = companion
    @companions = current_user.companions
    @message = @companion.received_messages.new()
    @messages = Message.between_users(current_user, @companion).ordered.page(params[:page]).per(20)
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    if @message.save
      @messages = Message.between_users(current_user, User.find(@message.recipient.id)).ordered.page(params[:page]).per(20)
    else
      flash.now[:notice] = 'aaaaaaa'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :recipient_id)
  end

  def companion
    current_user.companions.find(params[:id])
  end
end
