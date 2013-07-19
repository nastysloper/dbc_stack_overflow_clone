class Vote < ActiveRecord::Base
  attr_accessible :value, :comment_id, :user_id
  validates_uniqueness_of :user_id, :scope => :comment_id

  belongs_to :comment
  belongs_to :user
end