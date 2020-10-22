class Workshop < ApplicationRecord
  validates :name, :short_description, :full_description, :duration,
            :attendees, :workshop_date, :start_time, presence: true

  scope :future, -> { where('workshop_date > ?', Time.zone.now) }
end
