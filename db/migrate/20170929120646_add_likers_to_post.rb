class AddLikersToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :likers_count, :integer, default: 0
  end
end
