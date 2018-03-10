class CreateBookmarksTable < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.boolean :visited, default: false
    end
  end
end
