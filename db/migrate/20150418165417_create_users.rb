class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :avatar
      t.string :location
      t.string :work
      t.string :school
      t.datetime :birthday
      t.string :sex
      t.string :interest
      t.text :about
      t.integer :spark_count
    end
  end
end
