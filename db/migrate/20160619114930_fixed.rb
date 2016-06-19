class Fixed < ActiveRecord::Migration
  def change
    remove_column :ratings, :users_id
    remove_column :ratings, :bathrooms_id
    add_column :ratings, :user_id, :integer
    add_column :ratings, :bathroom_id, :integer 
  end
end