class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings

  validates :name, presence: true, uniqueness: true, length: { minimum: 1, maximum: 35 }
  validates :name, format: { with: /\A[a-z0-9\-\+\#]+\z/, message: "only allows lowercase letters, numbers, and -, +, #" }

  before_validation :downcase_name

  def to_param
    name
  end

  private

  def downcase_name
    self.name = name.downcase if name.present?
  end
end
