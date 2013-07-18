require 'spec_helper'
require_relative '../../app/models/user'

describe User do

  context "attribute accessibilitiy" do

    before do
      @user = User.new
    end

    it "returns oauth_token" do
      @user.update_attributes(oauth_token: "123")
      @user.save
      @user.oauth_token.should eq "123"
    end

    it "returns oauth_secret" do
      @user.update_attributes(oauth_secret: "123")
      @user.save
      @user.oauth_secret.should eq "123"
    end
  end

  context "associations" do
    it { should have_many(:created_events).class_name("Event").with_foreign_key(:organizer_id)}
    it { should have_many(:attendees) }

    it "has an attended_events method that returns an array" do
      user = User.new
      user.attended_events.should eq []
    end

    it { should have_many(:votes).with_foreign_key(:voter_id) }
    it { should have_many(:comments).with_foreign_key(:author_id) }

    it "has a voted_on_comments method that returns an array" do
      user = User.new
      user.voted_on_comments.should eq []
    end
  end

end