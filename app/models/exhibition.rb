class Exhibition < ApplicationRecord
  has_many :participations
  has_many :visits
  has_one_attached :photo

end
