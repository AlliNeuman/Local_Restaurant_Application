class RemoveColumnLocationId < ActiveRecord::Migration[5.1]
  def change
    remove_column(:restaurants, :location_id, :integer)
  end
end
