class Visit < ApplicationRecord
  belongs_to :exhibition
  has_many :messages
  has_many :subscriptions

end
