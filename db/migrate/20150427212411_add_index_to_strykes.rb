class AddIndexToStrykes < ActiveRecord::Migration
  def change
    add_index :strykes, :created_at
    add_index :strykes, :spark_count
  end
end
