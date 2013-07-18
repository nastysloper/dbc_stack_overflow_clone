require 'spec_helper'

describe VotesController do
  before(:all) do
    User.delete_all
    @user = User.create
    Vote.create(voter: @user, value: 1)
    User.create
  end

  before(:each) do
    @attrs = {voter_id: @user.id, value: 1}
  end

  describe '#create' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'saves a new vote' do
        count = Vote.all.count
        post :create, value: @attrs
        Vote.all.count.should eq count + 1
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session.clear
      end

      it 'doesnt save' do
        count = Vote.all.count
        post :create, value: @attrs
        Vote.all.count.should eq count
      end
    end
  end

  describe '#update' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'updates the vote at given id' do
        vote = Vote.find(1)
        attrs = {value: -1}
        post :update, :id => 1, vote: attrs
        vote.reload
        vote.value.should eq -1
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session[:user_id] = 2
      end

      it 'doesnt update if logged in user is not voter' do
        vote = Vote.find(1)
        attrs = {value: -1}
        post :update, :id => 1, vote: attrs
        vote.reload
        vote.value.should eq 1
      end
    end
  end

  describe '#destroy' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'destroys the object with the given id' do
        vote = Vote.create(@attrs)
        post :destroy, :id => vote.id
        expect {vote.reload}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session[:user_id] = 2
      end

      it 'does not destroy object' do
        vote = Vote.create(@attrs)
        post :destroy, :id => vote.id
        expect {vote.reload}.to_not raise_error
      end
    end
  end
end