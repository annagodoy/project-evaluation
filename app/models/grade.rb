class Grade < ApplicationRecord
  belongs_to :evaluation
  belongs_to :criterion

  validates :score, presence: true
end

