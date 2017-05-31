class Checkpoint < ApplicationRecord
  has_many :participations
  belongs_to :hunt
  acts_as_list scope: :hunt



  def lat_lng
    "#{lat},#{log}"
  end
end
