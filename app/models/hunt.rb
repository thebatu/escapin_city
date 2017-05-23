class Hunt < ApplicationRecord
  belongs_to :user
  has_one :category
  has_many :checkpoints
  has_many :participations
end
