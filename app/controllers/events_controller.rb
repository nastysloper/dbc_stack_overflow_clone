class EventsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]
  before_filter :user_created_event, only: [:edit, :update, :destroy]

  def user_created_event
    @event = current_user.created_events.find_by_id(params[:id])
    redirect_to '/' unless @event
  end

  def index
    #@events = Event.all
    @events = Event.order("start").limit(20)
  end

  def new
    @event = Event.new
  end

  def create
    current_user.created_events << Event.new(params[:event])
    redirect_to events_path
  end

  def show
    @event = Event.find(params[:id])
    session[:return_to] = event_path(@event)
  end

  def edit
  end

  def update
    @event.update_attributes(params[:event])
    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end
  
end