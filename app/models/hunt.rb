class Hunt < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :checkpoints, -> { order(position: :asc) }
  has_many :participations

  geocoded_by :city
  after_validation :geocode, if: :city_changed?

  accepts_nested_attributes_for :checkpoints

  def self.search(city, category_id)
    if !city.empty? && !category_id.empty?
      self.where(category_id: category_id).near(city, 200)
    elsif !city.empty?
      self.all.near(city, 200)
    elsif !category_id.empty?
      self.where(category_id: category_id)
    else
      self.all
    end
  end

  def gmap_path
    path.map { |(lat, log)| "#{lat},#{log}" }.join("|")
  end

  def path
    checkpoints.order(position: :asc).pluck(:lat, :log)
  end
end
