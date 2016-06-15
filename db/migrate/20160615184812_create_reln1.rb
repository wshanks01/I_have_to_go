class CreateReln1 < ActiveRecord::Migration
  def change
    add_reference :ratings, :bathrooms
  end
end
