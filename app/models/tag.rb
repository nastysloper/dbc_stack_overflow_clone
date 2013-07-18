class Tag < ActiveRecord::Base
  validates :name, :presence => true

  has_many :event_tags
  has_many :events, :through => :event_tags

end