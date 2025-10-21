class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: [:create]
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      render json: {
        comment: {
          id: @comment.id,
          body: @comment.body,
          user_email: @comment.user.email,
          created_at: @comment.created_at.strftime('%d %b %Y at %H:%M')
        },
        message: 'Comment added successfully'
      }
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.author?(@comment)
      @comment.destroy
      render json: { message: 'Comment deleted' }
    else
      render json: { error: 'You can only delete your own comments' }, status: :forbidden
    end
  end

  private

  def find_commentable
    if params[:question_id]
      @commentable = Question.find(params[:question_id])
    elsif params[:answer_id]
      @commentable = Answer.find(params[:answer_id])
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
