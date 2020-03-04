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

  def opened?(time)
     day = self.occurences.select do |occurence|
       time.localtime.to_date  ==  Date.parse(occurence[0])
     end
    if day == []
      return false
    else
      opening_hour = Time.parse(day[0][0])
      closing_hour = Time.parse(day[0][1])
      (opening_hour..closing_hour).include?(time.localtime)
    end
  end

  def time_to_opening(time)
    if self.opened?(time) == true
      day = self.occurences.select do |occurence|
        time.localtime.to_date  ==  Date.parse(occurence[0])
      end
      closing_hour = Time.parse(day[0][1])
      opening_hour = Time.parse(day[0][0])
      time_to_closing = Time.at(closing_hour-time.localtime).utc.strftime("%H:%M")
      return "Ferme dans<br> <div id='time' class='text-center'>#{time_to_closing}</div>"
    elsif self.opens_today?(time) == true
      day = self.occurences.select do |occurence|
        time.localtime.to_date  ==  Date.parse(occurence[0])
      end
      closing_hour = Time.parse(day[0][1])
      opening_hour = Time.parse(day[0][0])
      if opening_hour >= time.localtime
        time_to_opening = Time.at(opening_hour-time.localtime).utc.strftime("%H:%M")
      return "Ouvre dans<br> <div id='time' class='text-center'>#{time_to_opening}</div>"
      end
    end
  end

  def opens_today?(time)
    day = self.occurences.select do |occurence|
      time.localtime.to_date == Date.parse(occurence[0])
    end
    if day == []
      return false
    else
      return true
    end
  end





  def upcoming?
    Date.current < self.date_start
  end

  def finished?
    Date.current > self.date_end
  end

end

