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

def plural_count(count)
  if count == 1
    "#{count} Rating"
  else
    "#{count} Ratings"
  end
end

def plural_rating(rating)
  if rating <= 1
      "#{rating} Star"
    else
      "#{rating} Stars"
    end
end

end