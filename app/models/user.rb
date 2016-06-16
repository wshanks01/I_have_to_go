class User < ActiveRecord::Base
extend Geocoder::Model::ActiveRecord
geocoded_by :address
after_validation :geocode
has_many :ratings
has_many :bathrooms

end