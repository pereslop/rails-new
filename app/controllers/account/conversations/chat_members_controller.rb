class Account::Conversations::ChatMembersController < ApplicationController

  def index
    @conversation = conversation
    @chat_members = collection
  end

  def destroy
    @conversation = conversation
    @conversation.users.delete(User.find(params[:id]))
    @chat_members = @conversation.users

    render :index
  end

  private
    def collection
      conversation.users
    end

    def conversation
      Conversation.find(params[:conversation_id])
    end
end
