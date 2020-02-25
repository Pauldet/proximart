class Message < ApplicationRecord
  belongs_to :visits
  belongs_to :users
end
