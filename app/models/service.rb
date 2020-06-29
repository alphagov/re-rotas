class Service < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_and_belongs_to_many :teams

  validates :name, presence: true

  def score
    max_score = 2
    score = 0

    score += 1 unless description.blank?
    score += 1 unless documentation.blank?

    (score / max_score) * 5.0
  end
end
