class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|

      t.integer :raw_id
      t.text :content
      t.integer :unlock_level, default: 0
      t.integer :popular, default: 0

      t.timestamps null: false
    end
  end
end
