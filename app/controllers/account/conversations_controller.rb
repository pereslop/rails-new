class Account::ConversationsController < ApplicationController
  def index
    @conversation = collection.first

    read_conversation
    common

    render :chat
  end

  def new
    @conversation = current_user.conversations.new()
    @followers = followers
  end

  def create
    @conversation = Conversation.new(conversation_params)
    if @conversation.save
      @conversation.users << conversation_users << current_user
      read_conversation

      common
    end
    render :chat
  end

  def chat
    @conversation = resource

    read_conversation
    common
  end

  def recipient
    @conversation = recipient_conversation

    read_conversation
    common

    render :chat
  end

  private

  def read_conversation
    current_user.user_conversations.read_conversation(@conversation)
  end

  def common
    @conversations = current_user.conversations.ordered
    @messages = Message.for_conversation(@conversation)
    @message = Message.new()
  end

  def collection
    current_user.conversations.ordered
  end

  def resource
    collection.find(params[:id])
  end

  def conversation_params
    params.require(:conversation).permit(:title, :kind)
  end

  def conversation_users
    User.find(params[:conversation][:user_ids])
  end

  def recipient_conversation
    conversation = Conversation.between_users([current_user.id, params[:id]]).pair.first
    return conversation if conversation.present?

    new_conversation = current_user.conversations.create()
    new_conversation.users << User.find(params[:id])

    return new_conversation
  end

  def followers
    current_user.followers(User)
  end
end
