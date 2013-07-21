require 'spec_helper'

describe EventsController do
  before(:all) do
    User.delete_all
    @user = User.create
    @event = Event.create(organizer: @user, title: 'test title', start: Time.now, description: 'test description')
    User.create
  end

  before(:each) do
    @attrs = {organizer_id: @user.id, title: 'test title', start: Time.now, description: 'test description'}
  end

  describe '#index' do
    it 'assigns at least one Event to @events' do
      get :index
      assigns(:events).first.kind_of?(Event).should be_true
    end
  end

  describe '#new' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'assigns @event to an unsaved event' do
        get :new
        event = assigns(:event)
        event.kind_of?(Event).should be_true
        event.id.should be_nil
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session.clear
      end    

      it 'redirects if user not logged in' do
        get :new
        response.should_not be_success
      end
    end
  end

  describe '#create' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'saves a new event' do
        expect {post :create, event: @attrs}.to change{Event.count}.by(1)
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session.clear
      end

      it 'doesnt save' do
        expect {post :create, event: @attrs}.not_to change{Event.count}
      end
    end
  end

  describe '#show' do
    it 'assigns @event to Event with given id' do
      get :show, :id => @event.id
      event = assigns(:event)
      event.kind_of?(Event).should be_true
      event.id.should be @event.id
    end
  end

  describe '#edit' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'assigns @event to Event with given id' do
        get :edit, :id => @event.id
        event = assigns(:event)
        event.kind_of?(Event).should be_true
        event.id.should be @event.id
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session[:user_id] = 2
      end

      it 'should not succeed' do
        get :edit, :id => 1
        response.should_not be_success
      end
    end
  end

  describe '#update' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'updates the event at given id' do
        event = Event.create(@attrs)
        attrs = {title: 'updated test title', start: Time.now, description: 'test description'}
        post :update, :id => event.id, event: attrs
        event.reload
        event.title.should eq 'updated test title'
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session[:user_id] = 2
      end

      it 'doesnt update if logged in user is not organizer' do
        event = Event.create(@attrs)
        attrs = {title: 'updated test title', start: Time.now, description: 'test description'}
        post :update, :id => event.id, event: attrs
        event.reload
        event.title.should eq 'test title'
      end
    end
  end

  describe '#destroy' do
    context 'when user logged in' do
      before(:each) do
        session[:user_id] = @user.id
      end

      it 'destroys the object with the given id' do
        event = Event.create(@attrs)
        post :destroy, :id => event.id
        expect {event.reload}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when user not logged in' do
      before(:each) do
        session[:user_id] = 2
      end

      it 'does not destroy object' do
        event = Event.create(@attrs)
        post :destroy, :id => event.id
        expect {event.reload}.to_not raise_error
      end
    end
  end
end