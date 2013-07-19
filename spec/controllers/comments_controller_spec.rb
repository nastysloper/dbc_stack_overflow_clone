require 'spec_helper'

describe CommentsController do
  before(:all) do
    User.delete_all
    @user = User.create
    Comment.create(author: @user, text: 'test comment text')
    User.create
  end

  before(:each) do
    @attrs = {author_id: @user.id, text: 'test comment text'}
  end

  describe '#create' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'saves a new comment' do
        expect {post :create, comment: @attrs}.to change{Comment.count}.by(1)
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session.clear
      end

      it 'doesnt save' do
        expect {post :create, comment: @attrs}.not_to change{Comment.count}
      end
    end
  end

  describe '#update' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'updates the comment at given id' do
        comment = Comment.find(1)
        attrs = {text: 'updated test comment text'}
        post :update, :id => 1, comment: attrs
        comment.reload
        comment.text.should eq 'updated test comment text'
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session[:user_id] = 2
      end

      it 'doesnt update if logged in user is not author' do
        comment = Comment.find(1)
        attrs = {text: 'updated test comment text'}
        post :update, :id => 1, comment: attrs
        comment.reload
        comment.text.should eq 'test comment text'
      end
    end
  end

  describe '#destroy' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'destroys the object with the given id' do
        comment = Comment.create(@attrs)
        post :destroy, :id => comment.id
        expect {comment.reload}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session[:user_id] = 2
      end

      it 'does not destroy object' do
        comment = Comment.create(@attrs)
        post :destroy, :id => comment.id
        expect {comment.reload}.to_not raise_error
      end
    end
  end
end