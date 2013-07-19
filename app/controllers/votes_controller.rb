class VotesController < ApplicationController

  before_filter :user_created_votes, only: [:update, :destroy]

  def user_created_votes
    @vote = current_user.votes.find_by_id(params[:id])
    redirect_to '/' unless @vote
  end

  def create
    current_user.votes << Vote.new(params[:vote])
    redirect_to '/'
  end

  def update
    @vote.update_attributes(params[:vote])
    redirect_to '/'
  end

  def destroy
    @vote.destroy
    redirect_to '/'
  end

end