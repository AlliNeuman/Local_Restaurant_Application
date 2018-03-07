class AddColumnAddressToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :street_address, :string
  end
end
