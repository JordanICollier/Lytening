class AddNumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :num_type, :integer
  end
end
