# frozen_string_literal: true

class Enrollment < ApplicationRecord
  belongs_to :workshop
  belongs_to :attendee

  enum status: %i[enrolled waiting_list]
end
