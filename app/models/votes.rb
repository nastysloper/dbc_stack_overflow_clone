class Vote < ActiveRecord::Base
  attr_accessible :value, :comment, :voter

  belongs_to :comment
  belongs_to :voter, :class_name => "User"

end