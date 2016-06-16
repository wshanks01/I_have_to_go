class Bathroom < ActiveRecord::Base
extend Geocoder::Model::ActiveRecord
geocoded_by :address
after_validation :geocode
has_many :ratings

def rating_average
    self.ratings.average(:rating)
end

def rating_count
  self.ratings.count(:rating)
end

end