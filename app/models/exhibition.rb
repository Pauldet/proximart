class Exhibition < ApplicationRecord
  include ActiveModel::Dirty

  has_many :participations
  has_many :visits
  has_many :likes
  has_one_attached :photo
  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address_street?

  # include PgSearch
  # pg_search_scope :search_by_title_and_syllabus, against: [ :title, :category, :lead_text, :tags, :description, :date_start]



  def full_address
    address_name
  end
end

