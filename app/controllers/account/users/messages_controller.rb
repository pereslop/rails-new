class Account::Users::MessagesController < ApplicationController

  def new
    @recipient = recipient
    @message = Message.new
    @message.recipient_id = recipient.id
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    @message.save
    byebug
    render 'account/users/messages/create' if @message.save
  end

  private

    def collection
      Message.between(current_user, recipient)
    end

    def message_params
      params.require(:message).permit(:body, :recipient_id)
    end

    def resource
      collection.find(params[:id])
    end
  
    def recipient
      User.find(params[:user_id])
    end
end