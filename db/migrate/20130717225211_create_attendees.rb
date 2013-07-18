class CreateAttendees < ActiveRecord::Migration
  def up
    create_table :attendees do |t|
      t.belongs_to :user
      t.belongs_to :event
    end
  end

  def down
    drop_table :attendees
  end
end
