class Criterion < ApplicationRecord
  has_many :grades
  
  validates :weight, presence: true
end
