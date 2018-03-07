class RemoveColumnLocationId < ActiveRecord::Migration
  def change
    remove_column(:restaurants, :location_id, :integer)
  end
end
