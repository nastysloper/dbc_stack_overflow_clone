class CommentsController < ApplicationController

  before_filter :user_created_comment, only: [:update, :destroy]

  def user_created_comment
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to '/' unless @comment
  end

  def create
    new_comment = Comment.new(params[:comment])

    if new_comment.parent_id != nil
      new_comment.event_id = nil
    end

    current_user.comments << new_comment
    redirect_to event_path(params[:comment][:event_id])
  end

  def update
    @comment.update_attributes(params[:comment])
    redirect_to 
  end

  def destroy
    @comment.destroy
    redirect_to '/'
  end
  
end