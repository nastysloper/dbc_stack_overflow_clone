class CommentsController < ApplicationController

  before_filter :user_created_comment, only: [:update, :destroy]

  def user_created_comment
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to '/' unless @comment
  end

  def create
    current_user.comments << Comment.new(params[:comment])
    redirect_to '/'
  end

  def update
    @comment.update_attributes(params[:comment])
    redirect_to '/'
  end

  def destroy
    @comment.destroy
    redirect_to '/'
  end
  
end