class ChangeSexToGender < ActiveRecord::Migration
  def change
    rename_column :users, :sex, :gender
  end
end
