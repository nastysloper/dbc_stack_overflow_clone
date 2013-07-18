class CreateEventTags < ActiveRecord::Migration
  def up
    create_table :event_tags do |t|
      t.belongs_to :event
      t.belongs_to :tag
    end
  end

  def down
  end
end
