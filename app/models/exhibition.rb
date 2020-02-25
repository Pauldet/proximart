class Exhibition < ApplicationRecord
  include ActiveModel::Dirty

  has_many :participations
  has_many :visits
  has_one_attached :photo
  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address_street?


  def full_address
    address_name
    # concatener
  end

end
