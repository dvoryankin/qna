class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def author?(entity)
    id == entity.user_id
  end

  # Репутация пользователя на основе голосов за его вопросы и ответы
  def reputation
    question_votes = Vote.joins(:votable).where(votable_type: 'Question', votable: { user_id: id }).sum(:value)
    answer_votes = Vote.joins(:votable).where(votable_type: 'Answer', votable: { user_id: id }).sum(:value) * 2
    question_votes + answer_votes
  end
end
