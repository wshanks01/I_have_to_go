class CreateReln2 < ActiveRecord::Migration
  def change
    add_reference :ratings, :users
  end
end
