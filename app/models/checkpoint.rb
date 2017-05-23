class Checkpoint < ApplicationRecord
  belongs_to :hunt
  has_many :participations
end
