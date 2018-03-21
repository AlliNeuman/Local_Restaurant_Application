class AddTipsColumnToRestaurantsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :tips, :string
  end
end
