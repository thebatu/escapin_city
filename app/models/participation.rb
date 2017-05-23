class Participation < ApplicationRecord
  belongs_to :hunt
  belongs_to :user
  belongs_to :checkpoint
end
