# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Event.create(   :title => "Movie Night",
				:description => "Monsters University",
				:start => DateTime.now,
				:end => DateTime.now,
				:photo_file => "this is a photo",
				:organizer_id => 1
			)

Event.create(   :title => "Design Talk",
				:description => "Photoshop Stuff",
				:start => DateTime.now,
				:end => DateTime.now,
				:photo_file => "Photoshop logo",
				:organizer_id => 1
			)

Comment.create(	:text => "This is a new comment.",
				:author_id => 1,
				:event_id => 1,
				:parent_id => 1
				)

Comment.create(	:text => "This is a another comment.",
				:author_id => 1,
				:event_id => 1,
				:parent_id => 1
				)