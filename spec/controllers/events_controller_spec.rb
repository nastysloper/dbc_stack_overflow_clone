require 'spec_helper'

describe EventsController do
  before(:all) do
    user = User.create
    Event.create(organizer: user, title: 'test title', start: Time.now, description: 'test description')
    User.create
  end

  before(:each) do
    @attrs = {title: 'test title', start: Time.now, description: 'test description'}
  end

  describe '#index' do
    it 'assigns @events to Event.all' do
      events = double(:events)
      Event.stub(:all).and_return(events)

      get :index
      assigns(:events).should eq events
    end
  end

  describe '#new' do
    context 'user logged in' do
      before(:each) do
        session[:user_id] = 1
      end

      it 'assigns @event to an unsaved event' do
        get :new
        event = assigns(:event)
        event.kind_of?(Event).should be_true
        event.id.should be_nil
      end
    end

    context 'user not logged in' do
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

  describe '#show' do
    it 'assigns @event to Event with given id' do
      get :show, :id => 1
      event = assigns(:event)
      event.kind_of?(Event).should be_true
      event.id.should be 1
    end
  end

  describe '#edit' do
    context 'user logged in' do
      before(:each) do
        session[:user_id] = 1
      end

      it 'assigns @event to Event with given id' do
        get :edit, :id => 1
        event = assigns(:event)
        event.kind_of?(Event).should be_true
        event.id.should be 1
      end
    end

    context 'user not logged in' do
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
    context 'user logged in' do
      before(:each) do
        session[:user_id] = 1
      end

      it 'updates the event at given id' do
        event = Event.find(1)
        attrs = {title: 'updated test title', start: Time.now, description: 'test description'}
        post :update, :id => 1, event: attrs
        event.reload
        event.title.should eq 'updated test title'
      end
    end

    context 'user not logged in' do
      before(:each) do
        session[:user_id] = 2
      end

      it 'redirects if logged in user is not organizer' do
        event = Event.find(1)
        attrs = {title: 'updated test title', start: Time.now, description: 'test description'}
        post :update, :id => 1, event: attrs
        event.reload
        event.title.should eq 'test title'
      end
    end
  end

  describe '#destroy' do
    context 'user logged in' do
      before(:each) do
        session[:user_id] = 1
      end

      it 'destroys the object with the given id' do
        event = Event.create(@attrs)
        post :destroy, :id => event.id
        expect {event.reload}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'user not logged in' do
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