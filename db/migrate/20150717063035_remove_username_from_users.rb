class RemoveUsernameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :uid
    remove_column :users, :username
  end
end
