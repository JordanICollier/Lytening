class RenameNumTypeToSetupStepOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :num_type, :setup_step
  end
end
