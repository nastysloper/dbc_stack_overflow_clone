class Vote < ActiveRecord::Base

  belongs_to :comment
  belongs_to :voter, :class_name => "User"

end