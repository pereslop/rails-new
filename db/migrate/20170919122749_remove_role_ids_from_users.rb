class RemoveRoleIdsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :role_id, :string
  end
end
