class Bathroom < ActiveRecord::Base
extend Geocoder::Model::ActiveRecord
geocoded_by :address
after_validation :geocode
belongs_to :user

end