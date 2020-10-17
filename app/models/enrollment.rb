# frozen_string_literal: true

class Enrollment < ApplicationRecord
  belongs_to :workshop
  belongs_to :attendee
end
