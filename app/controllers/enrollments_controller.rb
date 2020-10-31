# frozen_string_literal: true

class EnrollmentsController < ApplicationController
  before_action :authenticate_attendee!

  def waiting_list_create
    workshop = Workshop.find(params[:workshop_id])

    workshop.waiting_list_enroll(current_attendee)

    redirect_to(workshop, flash: { success: I18n.t('enrollments.flash.success.waiting_list_enroll',
                                                   workshop_name: workshop.name) })
  rescue StandardError => e
    redirect_to(workshop, flash: { error: e.message })
  end
end
