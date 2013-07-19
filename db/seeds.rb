# Methods used in create entries
def random_user
	$all_users.sample
end

def random_event
	$all_events.sample
end

def random_tag
	Tag.find_or_create_by_name(Faker::Lorem.word)
end

def random_comment
	$all_comments.sample
end

def generate_start_date
	"2013-#{random_number((8..10).to_a)}-#{random_number((1..30).to_a)} #{random_number((0..23).to_a)}:#{random_number((0..59).to_a)}:00"
end

def random_number(choices)
	choices.sample
end

def comment_attributes
	{ author_id: random_user.id, text: Faker::Lorem.paragraph((1..3).to_a.sample) }
end

def up_or_down
	[1, -1].sample
end


# Create users
50.times do
	User.create(twitter_handle: Faker::Internet.user_name)
end

$all_users = User.all


# Create events
40.times do
	start_date = generate_start_date
	random_user.created_events.create( { :title => Faker::Lorem.sentence([4,5,6,7].sample),
																			 :description => Faker::Lorem.paragraph([1,2,3,4,5,6].sample),
																			 :start => start_date,
																			 :end =>  [nil, (start_date.to_i + (1800..18000).to_a.sample).to_s].sample } )
end

$all_events = Event.all


# Create attended_events, through attendees
175.times do
	user = random_user
	event = random_event
	user.attended_events << event unless event.organizer_id == user.id
end

# Create tags for events
130.times do
	random_event.tags << random_tag
end

# Create comments for events
120.times do
	random_event.comments << Comment.create(comment_attributes)
end


# Create comments for comments ... three rounds
3.times do
	$all_comments = Comment.all
	40.times do
		random_comment.replies.create(comment_attributes)
	end
end

# Create votes for users
$all_users.each do |user|
	30.times do
		vote = Vote.new( value: up_or_down, comment_id: random_comment.id )
		if vote.valid?
			vote.save
			user.votes << vote
		end
	end
end
