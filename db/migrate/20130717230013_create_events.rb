class CreateEvents < ActiveRecord::Migration
  
  def up
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start
      t.datetime :end
      t.string :photo_file
      t.integer :organizer_id

      t.timestamps
    end
  end

  def down
  end
end
