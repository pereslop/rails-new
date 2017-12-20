class Account::ConversationsController < ApplicationController
  def index
    redirect_to chat_account_conversation_path(collection.first)
  end

  def chat
    # @conversation = resource
    @conversations = collection
    byebug
    @messages = resource.messages
    # @message = resource.messages.new()
  end

  def create

  end

  private

  def collection
    current_user.conversations
  end

  def resource
    collection.find(params[:id])
  end
  def companions
    collection.for_users([current_user.id, ])
  end
end
