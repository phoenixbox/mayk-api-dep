class RemoveAuthenticationsUsers < ActiveRecord::Migration
  def change
    drop_table :authentications_users
  end
end
