class CreateAuthenticationsUsers < ActiveRecord::Migration
  def change
    create_table :authentications_users do |t|
      t.belongs_to 	:authentication
    	t.belongs_to 	:user
      t.timestamps
    end
    add_index :authentications_users, [:authentication_id, :user_id], :unique => true
  end
end
