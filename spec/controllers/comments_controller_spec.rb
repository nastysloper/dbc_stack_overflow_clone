require 'spec_helper'

describe CommentsController do
  before(:all) do
    user = User.create
    Comment.create(author: user, text: 'test comment text')
    User.create
  end

  before(:each) do
    @attrs = {text: 'test comment text'}
  end

  describe '#create' do
    it 'redirects if user not logged in' do
      pending
    end

    it 'should save a new comment' do
      count = Comment.all.count
      post :create, comment: @attrs
      Comment.all.count.should eq count + 1
    end
  end

  describe '#update' do
    it 'redirects if logged in user is not original commenter' do
      pending
    end

    it 'updates the comment at given id' do
      comment = Comment.find(1)
      attrs = {text: 'updated comment text'}
      post :update, :id => 1, comment: attrs
      comment.reload
      comment.text.should eq 'updated comment text'
    end
  end

  describe '#destroy' do
    it 'redirects if logged in user is not original commenter' do
      pending
    end
    
    it 'destroys the object with the given id' do
      comment = Comment.create(@attrs)
      post :destroy, :id => comment.id
      expect {comment.reload}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe '#create' do
    context 'user logged in' do
      before(:each) do
        session[:user_id] = 1
      end

      it 'saves a new event' do
        session[:user_id] = 1
        count = Event.all.count
        post :create, event: @attrs
        Event.all.count.should eq count + 1
      end
    end

    context 'user not logged in' do
      before(:each) do
        session.clear
      end

      it 'doesnt save' do
        count = Event.all.count
        post :create, event: @attrs
        Event.all.count.should eq count
      end
    end
  end
end