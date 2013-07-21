class VotesController < ApplicationController

  before_filter :user_created_votes, only: [:update, :destroy]

  def user_created_votes
    @vote = current_user.votes.find_by_id(params[:id])
    redirect_to '/' unless @vote
  end

  def create
    @vote = Vote.new(params[:vote])
    current_user.votes << @vote
    if request.xhr?
      @comment = @vote.comment
      render partial: "events/votes_forms"
    else
      redirect_to (session[:return_to] || '/')
    end
  end

  def update
    @vote.update_attributes(params[:vote])
    if request.xhr?
      @comment = @vote.comment
      render partial: "events/votes_forms"
    else
      redirect_to (session[:return_to] || '/')
    end
  end

  def destroy
    @comment = @vote.comment
    @vote.destroy
    @vote = nil
    if request.xhr?
      render partial: "events/votes_forms"
    else
      redirect_to (session[:return_to] || '/')
    end
  end

end