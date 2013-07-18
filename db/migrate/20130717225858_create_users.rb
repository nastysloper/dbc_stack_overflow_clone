class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :oauth_token
      t.string :oauth_secret
      t.string :twitter_handle

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
