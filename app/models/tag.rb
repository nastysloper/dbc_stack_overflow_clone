class Tag < ActiveRecord::Base
  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :event_tags
  has_many :events, :through => :event_tags

end