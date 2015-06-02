class RemoveSelfId < ActiveRecord::Migration
  def change
    remove_column :sparks, :self_id
  end
end
