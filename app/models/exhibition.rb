require "geocoder/stores/active_record"

class Exhibition < ApplicationRecord
  include ActiveModel::Dirty
  include Geocoder::Store::ActiveRecord

  has_many :participations
  has_many :visits
  has_many :likes
  has_one_attached :photo

  include Geocoder::Store::ActiveRecord

  def self.geocoder_options
    { latitude: 'latitude', longitude: 'longitude' }
  end

  # geocoded_by :full_address
  # after_validation :geocode, if: :will_save_change_to_address_street?

  # include PgSearch
  # pg_search_scope :search_by_title_and_syllabus, against: [ :title, :category, :lead_text, :tags, :description, :date_start]
  def update_average_rating
    average_rating = self.participations.pluck(:rating).sum / self.participations.size
    self.average_rating = average_rating
    self.ratings_count = self.participations.size
    self.save
  end

  def last_days?
    (Date.current..Date.current.end_of_week).include?(self.date_end)
  end

  # def full_address
  #   full_address
  # end
end

