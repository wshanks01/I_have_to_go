class Addadd2bathroom < ActiveRecord::Migration
  def change
    change_table :bathrooms do |b|
      b.text :address
    end
  end
end
