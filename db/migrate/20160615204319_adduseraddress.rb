class Adduseraddress < ActiveRecord::Migration
  def change
    change_table :users do |u|
      u.text :address
    end
  end
end
