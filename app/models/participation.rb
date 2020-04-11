class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :exhibition
  after_create :update_exhibition_rating
  validates :rating, :inclusion => 0..5


  def update_exhibition_rating
    self.exhibition.update_average_rating
  end
end
