require 'spec_helper'

describe Event do

  context "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:description) }
  end

  context "associations" do
    it { should belong_to(:organizer).class_name("User") }
    it { should have_many(:attendees) }

    it "should have a participants method that returns an array" do
      event = Event.new
      event.participants.should eq []
    end

    it { should have_many(:event_tags) }
    it { should have_many(:tags).through(:event_tags) }
    it { should have_many(:comments) }
  end

  context "uploading image" do
    pending
  end

end