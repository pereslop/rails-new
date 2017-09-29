class AddLikeesToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :likees_count, :integer, :default => 0
  end
end
