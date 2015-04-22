class ChangeAvatarField < ActiveRecord::Migration
  def change
    remove_column :users, :avatar
    add_attachment :users, :avatar
  end
end
