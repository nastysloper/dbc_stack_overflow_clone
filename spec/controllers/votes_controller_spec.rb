require 'spec_helper'

describe VotesController do
  before(:all) do
    User.delete_all
    @user = User.create
    @wrong_user = User.create
  end

  describe '#create' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'saves a new vote' do
        expect {post :create, value: @attrs}.to change{Vote.count}.by(1)
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session.clear
        Vote.delete_all
      end

      it 'doesnt save' do
        expect {post :create, value: @attrs}.not_to change{Vote.count}
      end
    end
  end

  describe '#update' do
    before(:each) do
      Vote.delete_all
      @vote = Vote.create(voter: @user, value: 1)
    end

    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'updates the vote at given id' do
        attrs = {value: -1}
        post :update, :id => @vote.id, vote: attrs
        @vote.reload
        @vote.value.should eq -1
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session[:user_id] = @wrong_user.id
      end

      it 'doesnt update if logged in user is not voter' do
        attrs = {value: -1}
        post :update, :id => @vote.id, vote: attrs
        @vote.reload
        @vote.value.should eq 1
      end
    end
  end

  describe '#destroy' do
    before(:each) do
      Vote.delete_all
      @vote = Vote.create(voter: @user, value: 1)
    end

    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'destroys the object with the given id' do
        post :destroy, :id => @vote.id
        expect {@vote.reload}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session[:user_id] = @wrong_user.id
      end

      it 'does not destroy object' do
        post :destroy, :id => @vote.id
        expect {@vote.reload}.to_not raise_error
      end
    end
  end
end