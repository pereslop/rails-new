class Account::ConversationsController < ApplicationController
  def index
    redirect_to chat_account_conversation_path(collection.first)
  end

  def chat
  @conversations = collection
  @conversation = resource
  @messages = @conversation.messages
  @message = @conversation.messages.new()
  puts ''
    # @message = resource.messages.new()
  end

  def create

  end

  private

  def collection
    current_user.conversations
  end

  def resource
    byebug
    collection.find(params[:id])
  end

  def companions
    collection.for_users([current_user.id, ])
  end
end
