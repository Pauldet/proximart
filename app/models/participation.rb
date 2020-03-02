class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :exhibition
  after_create :update_exhibition_rating


  def update_exhibition_rating
    self.exhibition.update_average_rating
  end
end
