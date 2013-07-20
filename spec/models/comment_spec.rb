require 'spec_helper'

describe Comment do
  
  before(:all) do
    @user = User.create
    @comment = Comment.new(text: 'test')
    @vote = Vote.create(voter: @user, value: 0)
    @sum = 0
    @comment.votes << @vote
    10.times do |i|
      value = rand(25)
      @comment.votes << Vote.new(voter_id: i+1000, value: value)
      @sum += value
    end
  end

  context "validations" do
    it { should validate_presence_of(:text) }
  end

  context "associations" do
    it { should belong_to(:event) }
    it { should belong_to(:author).class_name("User") }
    it { should belong_to(:parent).class_name("Comment") }
    it { should have_many(:replies).class_name("Comment").with_foreign_key(:parent_id) }
  end

  describe '#votes_sum' do
    it 'sums value of all votes for this comment' do
      @comment.votes_sum.should eq @sum
    end
  end

  describe '#vote_by' do
    it 'finds a vote by the given user if it exists' do
      @comment.vote_by(@user).should eq @vote
    end
  end
end