require 'spec_helper'

describe EventsController do
  before(:all) do
    Event.create(title: 'test title', start: Time.now, description: 'test description')
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
    it 'redirects if user not logged in' do
      pending
    end

    it 'assigns @event to an unsaved' do
      get :new
      event = assigns(:event)
      event.kind_of?(Event).should be_true
      event.id.should be_nil
    end
  end

  describe '#create' do
    it 'redirects if user not logged in' do
      pending
    end

    it 'should save a new event' do
      count = Event.all.count
      post :create, event: @attrs
      Event.all.count.should eq count + 1
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
    it 'redirects if logged in user is not organizer' do
      pending
    end

    it 'assigns @event to Event with given id' do
      get :edit, :id => 1
      event = assigns(:event)
      event.kind_of?(Event).should be_true
      event.id.should be 1
    end
  end

  describe '#update' do
    it 'redirects if logged in user is not organizer' do
      pending
    end

    it 'updates the event at given id' do
      event = Event.find(1)
      attrs = {title: 'updated test title', start: Time.now, description: 'test description'}
      post :update, :id => 1, event: attrs
      event.reload
      event.title.should eq 'updated test title'
    end
  end

  describe '#destroy' do
    it 'redirects if logged in user is not organizer' do
      pending
    end
    
    it 'destroys the object with the given id' do
      event = Event.create(@attrs)
      post :destroy, :id => event.id
      expect {event.reload}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end