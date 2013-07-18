class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :oauth_token
      t.string :oauth_secret

      t.timestamps
    end
  end

  def down
  end
end
