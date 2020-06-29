class Service < ApplicationRecord
  validates :name, presence: true

  def score
    max_score = 2
    score = 0

    score += 1 unless description.blank?
    score += 1 unless documentation.blank?

    (score / max_score) * 5.0
  end
end
