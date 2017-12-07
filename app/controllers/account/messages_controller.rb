class Account::MessagesController < ApplicationController

  def index
    @companions = companion
    @messages = collection
  end

  def create
    puts ''
  end

  private

    def companions
      User.find(params[:id])
    end

    def collection
      Message.between(current_user, recipient)
    end
end