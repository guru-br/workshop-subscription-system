# frozen_string_literal: true

class Workshop < ApplicationRecord
  STATUSES = %i[draft active inactive]

  validates :name, :short_description, :full_description, :duration,
            :attendees, :workshop_date, :start_time, :status, presence: true

  scope :future, -> { where('workshop_date > ?', Time.zone.now) }

  enum status: STATUSES
end
