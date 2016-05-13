class Attendee < ActiveRecord::Base
	belongs_to :event # singular
end
