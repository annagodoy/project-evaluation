class Project < ApplicationRecord
  validates :name, presence: true

  has_many :evaluations, dependent: :destroy
end