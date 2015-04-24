class CreateStrykes < ActiveRecord::Migration
  def change
    create_table :strykes do |t|
      t.string :body
      t.string :image_url
      t.attachment :image
      t.integer :spark_count
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :user_id
    end
  end
end
