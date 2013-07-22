class RsvpsController < ApplicationController

  def rsvp
    @event = Event.find(params[:id])
    current_user.attended_events << @event
    render partial: "sidebars/show_rsvp_attending"
  end

end