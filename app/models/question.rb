class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, :body, presence: true, length: { minimum: 10, maximum: 200 }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  # Вычисляемый рейтинг на основе голосов
  def score
    votes.sum(:value)
  end

  # Получить голос текущего пользователя
  def vote_by(user)
    votes.find_by(user: user)
  end

  # Увеличить счетчик просмотров
  def increment_views!
    increment!(:views_count)
  end

  # Теги в виде строки
  def tag_list
    tags.pluck(:name).join(', ')
  end

  # Установить теги из строки
  def tag_list=(names)
    self.tags = names.to_s.split(',').map do |n|
      Tag.where(name: n.strip.downcase).first_or_create!
    end.compact
  end
end
