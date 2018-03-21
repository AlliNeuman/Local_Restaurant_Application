class DropTableLocation < ActiveRecord::Migration[5.1]
  def down
    drop_table(:locations)
  end
end
