class TagsController < ApplicationController
  def index
    @tags = Tag.joins(:questions)
                .group('tags.id')
                .select('tags.*, COUNT(questions.id) as questions_count')
                .order('questions_count DESC')
  end

  def show
    @tag = Tag.find_by!(name: params[:id])
    @questions = @tag.questions.includes(:user, :answers, :tags).order(created_at: :desc)
  end
end
