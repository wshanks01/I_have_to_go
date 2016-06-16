class User < ActiveRecord::Base
extend Geocoder::Model::ActiveRecord
geocoded_by :address
after_validation :geocode

end