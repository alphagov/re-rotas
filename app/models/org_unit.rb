class OrgUnit < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :teams
  has_many :services, through: :teams

  validates :name, presence: true
end
