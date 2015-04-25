class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :stryke_id
      t.integer :spark_count
      t.integer :user_id
    end
  end
end
