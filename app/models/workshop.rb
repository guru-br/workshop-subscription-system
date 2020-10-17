# frozen_string_literal: true

class Workshop < ApplicationRecord
  validates :name, :short_description, :full_description, :duration,
            :attendees, :workshop_date, :start_time, presence: true
end
