class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :uuid, :string, null: false
  end
end
