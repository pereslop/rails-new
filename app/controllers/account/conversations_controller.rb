class Account::ConversationsController < ApplicationController
  def index
    @conversation = collection.first

    common

    render :chat
  end

  def chat
    @conversation = resource
    common
  end

  private

  def common
    @conversations = collection
    @messages = @conversation.messages
    @message = @conversation.messages.new()
  end

  def collection
    current_user.conversations
  end

  def resource
    unless params[:user_id].nil?
      if Conversation.between_users([current_user.id, params[:user_id]]).empty?
        conversation = current_user.conversations.create()
        conversation.users << User.find(params[:user_id])
        return conversation
      end
    end
    return collection.find(params[:id])
  end

  def companions
    collection.for_users([current_user.id, ])
  end
end
