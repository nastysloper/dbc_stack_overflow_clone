50.times do
	User.create(twitter_handle: Faker::Internet.user_name)
end

def all_users
	User.all
end

def generate_start_date
	"2013-#{random_number((8-10).to_a)}-#{random_number((1-31).to_a)} #{random_number((0-23).to_a)}:#{random_number((0-59).to_a)}:00"
end

def random_number(choices)
	choices.sample
end

100.times do
	start = generate_start_date
	user = all_users.sample
	user.created_events.create( { :title => Faker::Lorem.sentence([4,5,6,7].sample),
																:description => Faker::Lorem.paragraph([1,2,3,4,5,6].sample)
																:start => start,
																:end =>  [nil, start + (1800-18000).to_a.sample].sample } )
end

def all_events
	Event.all
end

150.times do
	user = all_users.sample
	event = all_events
	user.attended_events << event unless event.organizer_id == user.id
end
