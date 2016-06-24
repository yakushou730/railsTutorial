class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|

      t.string :raw_id
      t.string :parkname
      t.string :administrativeArea
      t.string :location
      t.string :park_type
      t.text :introduction

      t.timestamps null: false
    end
  end
end
