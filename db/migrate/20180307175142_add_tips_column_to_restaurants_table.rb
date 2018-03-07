class AddTipsColumnToRestaurantsTable < ActiveRecord::Migration
  def change
    add_column :restaurants, :tips, :string
  end
end
