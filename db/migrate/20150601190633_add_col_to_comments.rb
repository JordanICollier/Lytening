class AddColToComments < ActiveRecord::Migration
  def change
    add_column :comments, :body_html, :string
    add_column :strykes, :body_html, :string
  end
end
