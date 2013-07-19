class User < ActiveRecord::Base
  attr_accessible :oauth_token, :oauth_secret, :id, :twitter_handle
  
  has_many :created_events, :class_name => "Event", :foreign_key => :organizer_id
  has_many :attendees
  has_many :attended_events, :through => :attendees, :source => :event
  has_many :votes
  has_many :comments, :foreign_key => :author_id
  has_many :voted_on_comments, :through => :votes, :source => :comment


  def twitter_client
    @twitter_client ||= Twitter::Client.new(:oauth_token => oauth_token,
                                            :oauth_token_secret => oauth_secret)
  end

end