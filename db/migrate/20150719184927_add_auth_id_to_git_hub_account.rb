class AddAuthIdToGitHubAccount < ActiveRecord::Migration
  def change
    add_column :github_accounts, :authentication_id, :integer, null: false
    add_index :github_accounts, :authentication_id
  end
end
