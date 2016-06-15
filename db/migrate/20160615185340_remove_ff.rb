class RemoveFf < ActiveRecord::Migration
  def change
    remove_column :bathrooms, :family_friendly, :text
  end
end