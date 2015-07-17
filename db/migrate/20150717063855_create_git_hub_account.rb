class CreateGitHubAccount < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    create_table :github_accounts do |t|
      t.string :uid, null: false
      t.string :username, null: false
      t.string :display_name, null: false
      t.string :email, null: false
      t.hstore :raw
    end
    add_index :github_accounts, :raw, using: :gin
  end
end
