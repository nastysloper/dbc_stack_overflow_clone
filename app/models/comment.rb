class Comment < ActiveRecord::Base
  attr_accessible :text
  
  validates :text, :presence => true

  belongs_to :event
  belongs_to :author, :class_name => "User"
  has_many :replies, :class_name => "Comment", :foreign_key => :parent_id
  belongs_to :parent, :class_name => "Comment"

end