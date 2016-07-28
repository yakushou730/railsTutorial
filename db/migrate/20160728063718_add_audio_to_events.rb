class AddAudioToEvents < ActiveRecord::Migration
  def change
    add_attachment :events, :sound
  end
end
