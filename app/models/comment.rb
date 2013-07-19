class Comment < ActiveRecord::Base

  attr_accessible :text, :author, :author_id, :parent, :parent_id
  
  validates :text, :presence => true

  belongs_to :parent, :class_name => "Comment"
  belongs_to :event
  belongs_to :author, :class_name => "User"
  has_many :replies, :class_name => "Comment", :foreign_key => :parent_id
  has_many :votes
  belongs_to :parent, :class_name => "Comment"

  def upDownSum
    votes.inject(0) {|acc, v| acc += v.value}
  end
end