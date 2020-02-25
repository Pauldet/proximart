class Visit < ApplicationRecord
  belongs_to :exhibitions
  has_many :messages
  has_many :subscriptions

end
