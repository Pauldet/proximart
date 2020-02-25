class Participation < ApplicationRecord
  belongs_to :users
  belongs_to :exhibitions
end
