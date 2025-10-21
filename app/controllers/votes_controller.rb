class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_votable

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  def cancel
    @vote = @votable.votes.find_by(user: current_user)
    if @vote
      @vote.destroy
      render json: { score: @votable.score, message: 'Vote cancelled' }
    else
      render json: { error: 'No vote to cancel' }, status: :unprocessable_entity
    end
  end

  private

  def vote(value)
    if current_user.author?(@votable)
      render json: { error: 'You cannot vote for your own content' }, status: :forbidden
      return
    end

    @vote = @votable.votes.find_or_initialize_by(user: current_user)

    if @vote.persisted? && @vote.value == value
      render json: { error: 'You already voted this way' }, status: :unprocessable_entity
    elsif @vote.update(value: value)
      render json: { score: @votable.score, message: 'Vote recorded' }
    else
      render json: { errors: @vote.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def find_votable
    if params[:question_id]
      @votable = Question.find(params[:question_id])
    elsif params[:answer_id]
      @votable = Answer.find(params[:answer_id])
    end
  end
end
