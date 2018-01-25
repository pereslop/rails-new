class CreateUserConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_conversations do |t|

      t.timestamps
    end
  end
end
