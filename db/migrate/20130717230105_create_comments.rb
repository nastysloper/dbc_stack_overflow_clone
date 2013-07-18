class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.text :text
      t.integer :author_id
      t.belongs_to :event
      t.integer :parent_id
      t.boolean :endorsed, default: false

      t.timestamps
    end
  end

  def down
  end
end
