# frozen_string_literal: true

class Workshop < ApplicationRecord
  has_many :enrollments, dependent: :restrict_with_exception

  STATUSES = %i[draft active inactive].freeze

  validates :name, :short_description, :full_description, :duration,
            :attendees, :workshop_date, :start_time, :status, presence: true

  scope :future, -> { where('workshop_date > ?', Time.zone.now) }

  enum status: STATUSES

  def full?
    enrollments.size >= attendees
  end

  def enrolled?(attendee)
    enrollments.where(attendee: attendee, status: :enrolled).any?
  end

  def waiting_list_enroll(attendee)
    return nil unless full?

    enrollments.create!(attendee: attendee, status: :waiting_list)
  end

  def disenroll(attendee)
    enrollments.find_by(attendee: attendee, status: :enrolled)&.destroy
  end
end
