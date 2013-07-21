class CommentsController < ApplicationController

  before_filter :user_created_comment, only: [:update, :destroy]

  def user_created_comment
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to '/' unless @comment
  end

  def create
    @comment = Comment.new(params[:comment])
    current_user.comments << @comment
    if request.xhr?
      @comment = @comment.parent if @comment.parent
      render partial: "events/show_comment"
    else
      redirect_to (session[:return_to] || '/')
    end
  end

  def update
    @comment.update_attributes(params[:comment])
    if request.xhr?
      render partial: "events/show_comment"
    else
      redirect_to (session[:return_to] || '/')
    end
  end

  def destroy
    id = @comment.id
    @comment.destroy
    if request.xhr?
      p '===================================='
      render text: id
    else
      p '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      redirect_to (session[:return_to] || '/')
    end
  end
  
end