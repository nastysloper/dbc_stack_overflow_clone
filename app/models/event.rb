class Event < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'

  attr_accessible :title, :start, :description, :organizer, :organizer_id

  validates :title, :presence => true
  validates :start, :presence => true
  validates :description, :presence => true

  belongs_to :organizer, :class_name => "User"
  has_many :attendees
  has_many :participants, :through => :attendees, :source => :users
  has_many :event_tags
  has_many :tags, :through => :event_tags
  has_many :comments

  mount_uploader :photo_file, PhotoUploader


end