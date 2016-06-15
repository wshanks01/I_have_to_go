class Development < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.text :username, presence: true
      u.text :pwd, presence: true
      u.text :email, presence: true
    end
  end
end