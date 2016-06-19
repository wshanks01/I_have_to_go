class User < ActiveRecord::Base
extend Geocoder::Model::ActiveRecord
geocoded_by :address
reverse_geocoded_by :latitude, :longitude
after_validation :geocode, :reverse_geocode
has_many :ratings
has_many :bathrooms

end