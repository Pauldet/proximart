class Exhibition < ApplicationRecord
  has_many :participations
  has_many :visits
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch
  pg_search_scope :search_by_title_and_syllabus, against: [ :title, :category, :lead_text, :tags, :description, :date_start]

end
