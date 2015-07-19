class AddTokenToGithubAccount < ActiveRecord::Migration
  def change
    add_column :github_accounts, :token, :string
  end
end
