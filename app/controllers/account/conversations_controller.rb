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

  def create

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
    collection.find(params[:id])
  end

  def companions
    collection.for_users([current_user.id, ])
  end
end
