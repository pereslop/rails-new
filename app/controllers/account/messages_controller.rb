class Account::MessagesController < ApplicationController

  def index
    @messages = collection
  end

  def sent
    @messages = collection.sent
  end

  def received
    @messages = collection.received
  end

  def new
  end

  def create
  end

  private

    def collection
      Message.all_for_user(current_user)
    end
end