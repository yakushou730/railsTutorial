class AddAvatarColumnsToEvents < ActiveRecord::Migration
  def change
     add_attachment :events, :avatar
  end
end
