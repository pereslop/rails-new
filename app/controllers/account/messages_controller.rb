class Account::MessagesController < ApplicationController

  def index
    @companion = companions.first
    redirect_to chat_account_message_path(@companion)
  end

  def chat
    @companion = companion
    @companions = companions
    @message = Message.new
    @message.recipient_id = @companion.id
    @messages = Message.between_users(current_user, @companion).ordered.page(params[:page]).per(20)
    respond_to do |format|
      format.html { render 'account/messages/chat' }
      format.js { render 'account/messages/chat' }
    end
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    @message.save
    if @message.save
      @messages = Message.between_users(current_user, User.find(@message.recipient.id)).ordered.page(params[:page]).per(20)
    else
      flash[:danger] = @message.errors.messages
    end
  end

  private

    def message_params
      params.require(:message).permit(:body, :recipient_id)
    end

    def companion
      User.find(params[:id])
    end

    def companions
      companions_ids = current_user.companions(current_user.messages)
      User.find(companions_ids).without(current_user)
    end
end
