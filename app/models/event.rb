class Event < ActiveRecord::Base
	has_many :attendees, dependent: :destroy # plural
	belongs_to :category
	has_one :location, dependent: :destroy

	has_many :event_groupships
	has_many :groups, through: :event_groupships
	validates_presence_of :name

  belongs_to :user

  #delegate :name, to: :category, prefix: true, allow_nil: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
