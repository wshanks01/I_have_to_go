class AddWheelchair < ActiveRecord::Migration
  def change
    add_column :bathrooms, :wheelchair_access, :text
  end
end