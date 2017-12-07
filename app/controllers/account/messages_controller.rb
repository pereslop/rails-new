class Account::MessagesController < ApplicationController

  def index
    @companions = companions
    @messages = @companions.first.messages
  end

  private

    def companions
      User.find(current_user.companions(current_user.messages))
    end

    def collection
      Message.between(current_user, companions.first)
    end
end
