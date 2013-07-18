require 'spec_helper'

describe VotesController do
  before(:all) do
    Vote.create(value: 1)
  end

  before(:each) do
    @attrs = {value: 1}
  end

  describe '#create' do
    it 'redirects if user not logged in' do
      pending
    end

    it 'should save a new vote' do
      count = Vote.all.count
      post :create, vote: @attrs
      Vote.all.count.should eq count + 1
    end
  end

  describe '#update' do
    it 'redirects if logged in user is not original voter' do
      pending
    end

    it 'updates the vote at given id' do
      vote = Vote.find(1)
      attrs = {value: -1}
      post :update, :id => 1, vote: attrs
      vote.reload
      vote.value.should eq -1
    end
  end

  describe '#destroy' do
    it 'redirects if logged in user is not original voter' do
      pending
    end
    
    it 'destroys the object with the given id' do
      vote = Vote.create(@attrs)
      post :destroy, :id => vote.id
      expect {vote.reload}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end