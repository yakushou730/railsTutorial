class Attendee < ActiveRecord::Base
	belongs_to :event # singular
	validates_presence_of :name
end
