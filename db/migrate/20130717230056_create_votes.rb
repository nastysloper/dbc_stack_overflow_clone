class CreateVotes < ActiveRecord::Migration
  def up
    create_table :votes do |t|
      t.integer :voter_id
      t.belongs_to :comment
      t.integer :value

      t.timestamps
    end
  end

  def down
  end
end
