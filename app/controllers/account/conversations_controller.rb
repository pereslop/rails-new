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

  def recipient
    @conversation = recipient_conversation

    common

    render :chat
  end
  private

  def common
    @conversations = collection
    @messages = Message.for_conversation(@conversation)
    @message_body = MessageBody.new()
  end

  def collection
    current_user.conversations
  end

  def resource
    collection.find(params[:id])
  end

  def recipient_conversation
    conversation = Conversation.between_users([current_user.id, params[:id]]).first
    return conversation if conversation.present?

    new_conversation = current_user.conversations.create()
    new_conversation.users << User.find(params[:id])
    return new_conversation
  end
end
