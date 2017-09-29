class AddLikeesCountToLikes < ActiveRecord::Migration[5.1]
  def change
    add_column :likes, :likers_count, :integer, :default => 0
  end
end
