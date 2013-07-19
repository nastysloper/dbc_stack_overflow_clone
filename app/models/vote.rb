class Vote < ActiveRecord::Base
  attr_accessible :value, :comment, :comment_id, :voter, :voter_id
  validates_uniqueness_of :voter_id, :scope => :comment_id

  belongs_to :comment
  belongs_to :voter, :class_name => "User"
end