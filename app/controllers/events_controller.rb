class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
  end

  def create

  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end