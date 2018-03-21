class CreateRestaurant < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :category
      t.integer :user_id
      t.integer :location_id
    end
  end
end
