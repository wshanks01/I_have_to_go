class Rating < ActiveRecord::Base
  validates :rating, presence: true
  belongs_to :bathroom
  belongs_to :user
end