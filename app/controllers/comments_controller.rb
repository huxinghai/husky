class CommentsController < ApplicationController
  before_filter :find_commentable
  before_filter :authenticate_user!, only: [:create]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.json{ render json: @comment }
      else
        format.json{ render json: {messages: @comment.errors.full_messages}, status: 403 }
      end
    end
  end

  private
  def find_commentable
    key = "#{params[:model].underscore}_id"
    @commentable = params[:model].constantize.find(params[key])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end