class DropTableConversationsUsers < ActiveRecord::Migration[5.1]
  def change
    drop_table :conversations_users
  end
end
