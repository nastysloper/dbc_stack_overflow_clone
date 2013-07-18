class EventsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    current_user.created_events << Event.new(params[:event])
    redirect_to '/'
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = current_user.created_events.find_by_id(params[:id])
    redirect_to '/' unless @event
  end

  def update
    event = current_user.created_events.find_by_id(params[:id])
    event.update_attributes(params[:event]) if event
    redirect_to '/'
  end

  def destroy
    event = current_user.created_events.find_by_id(params[:id])
    event.destroy if event
    redirect_to '/'
  end
  
end