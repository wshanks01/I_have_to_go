class AddFamily < ActiveRecord::Migration
  def change
    add_column :bathrooms, :family_friendly, :text
  end
end