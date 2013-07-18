class EventsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]
  before_filter :user_created_event, only: [:edit, :update, :destroy]

  def user_created_event
    @event = current_user.created_events.find_by_id(params[:id])
    redirect_to '/' unless @event
  end

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
  end

  def update
    @event.update_attributes(params[:event])
    redirect_to '/'
  end

  def destroy
    @event.destroy
    redirect_to '/'
  end
  
end