class Grade < ApplicationRecord
  belongs_to :evaluation
  belongs_to :criterion

  validates :score, :evaluation_id, :criterion_id, presence: true
end

