class DropTableLocation < ActiveRecord::Migration
  def down
    drop_table(:locations)
  end
end
