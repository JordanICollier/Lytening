class MakeStrykesPolymorphic < ActiveRecord::Migration
  def change
    # remove existing columns
    remove_column :sparks, :stryke_id, :integer, index:true
    remove_column :sparks, :comment_id, :integer, index: true
    add_reference :sparks, :sparkable, polymorphic: true, index: true
  end
end
