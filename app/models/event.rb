class Event < ActiveRecord::Base
	has_many :attendees, dependent: :destroy # plural
	belongs_to :category
	has_one :location, dependent: :destroy

	has_many :event_groupships
	has_many :groups, through: :event_groupships
	validates_presence_of :name

  belongs_to :user

  #delegate :name, to: :category, prefix: true, allow_nil: true
end
