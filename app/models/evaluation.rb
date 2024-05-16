class Evaluation < ApplicationRecord
  belongs_to :project

  validates :project_id, :title, presence: true

  has_many :grades, dependent: :destroy
  accepts_nested_attributes_for :grades, allow_destroy: true
end