class AddStartTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :start_time, :datetime
  end
end
