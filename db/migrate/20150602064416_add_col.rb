class AddCol < ActiveRecord::Migration
  def change
    add_column :sparks, :self_id, :integer
  end
end
