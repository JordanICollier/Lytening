class CreateSparks < ActiveRecord::Migration
  def change
    create_table :sparks do |t|
      t.integer :user_id
      t.integer :stryke_id
      t.integer :comment_id
    end
  end
end
