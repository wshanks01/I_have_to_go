class CreateTable2 < ActiveRecord::Migration
  def change
    create_table :ratings do |r|
      r.integer :rating, presence: true
    end
  end
end
