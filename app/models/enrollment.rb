# frozen_string_literal: true

class Enrollment < ApplicationRecord
  belongs_to :workshop
  belongs_to :attendee

  validates :status, presence: true
  validate :already_enrolled, :already_enrolled_waiting_list

  enum status: { enrolled: 0, waiting_list: 1 }

  def already_enrolled
    return if self.class.where(workshop: workshop, attendee: attendee, status: :enrolled).empty?

    errors.add(:base, I18n.t('enrollments.flash.error.already_enrolled', workshop_name: workshop.name))
  end

  def already_enrolled_waiting_list
    return if self.class.where(workshop: workshop, attendee: attendee, status: :waiting_list).empty?

    errors.add(:base, I18n.t('enrollments.flash.error.already_enrolled_waiting_list', workshop_name: workshop.name))
  end
end
