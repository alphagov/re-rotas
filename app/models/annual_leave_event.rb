class AnnualLeaveEvent < ApplicationRecord
  validates :email, presence: true
end
