class Addlonglat2user < ActiveRecord::Migration
  def change
    change_table :users do |u|
      u.float :longitude
      u.float :latitude
    end
  end
end
