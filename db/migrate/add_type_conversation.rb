class AddTypeToConversation < ActiveRecord::Migration[5.1]
  def change
    add_column :conversations, :type, :integer
  end
end
