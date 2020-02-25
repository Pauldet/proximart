class Subscription < ApplicationRecord
  belongs_to :users
  belongs_to :visits
end
