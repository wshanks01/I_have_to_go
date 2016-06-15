class CreateTable3 < ActiveRecord::Migration
  def change
     create_table :bathrooms do |b|
       b.text :store_name, presence: true
       b.float :longitude, presence: true
       b.float :latitude, presence: true
       b.boolean :family_friendly, presence: true
    end
  end
end
