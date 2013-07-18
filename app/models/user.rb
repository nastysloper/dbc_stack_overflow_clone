class User < ActiveRecord::Base
  attr_accessible :oauth_token, :oauth_secret
  
  has_many :created_events, :class_name => "Event", :foreign_key => :organizer_id
  has_many :attendees
  has_many :attended_events, :through => :attendees, :source => :events
  has_many :votes, :foreign_key => :voter_id
  has_many :comments, :foreign_key => :author_id
  has_many :voted_on_comments, :through => :votes, :source => :comments


  def twitter_client
    @twitter_client ||= Twitter::Client.new(:oauth_token => oauth_token,
                                            :oauth_token_secret => oauth_secret)
  end

end