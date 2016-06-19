class AddUserid < ActiveRecord::Migration
  def change
    add_column :bathrooms, :user_id, :integer
  end
end