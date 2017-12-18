class CreateUserConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_conversations do |t|
        t.references :user, index:true
        t.references :conversation, index:true
      t.timestamps
    end
  end
end
