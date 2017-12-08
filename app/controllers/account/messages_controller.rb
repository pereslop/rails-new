class Account::MessagesController < ApplicationController

  def index
    @companions = companions
    @companion = @companions.first
    @messages = @companion.messages.page(params[:page]).per(20)
  end

  def chat
    @companion = companion
    @companions = companions
    @message = Message.new
    @message.recipient_id = @companion.id
    @messages = Message.between_users(current_user, @companion).ordered.page(params[:page]).per(20)
    puts ''
  end

  private

    def companion
      User.find(params[:id])
    end

    def companions
      User.find(current_user.companions(current_user.messages))
    end
end
