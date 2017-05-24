class Hunt < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :checkpoints
  has_many :participations

  geocoded_by :city
  after_validation :geocode, if: :city_changed?
end
