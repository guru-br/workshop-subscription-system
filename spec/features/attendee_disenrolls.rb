# frozen_string_literal: true

require 'rails_helper'

feature 'Attendee disenrolls' do
  scenario 'successfully' do
    attendee = create(:attendee)
    workshop = create(:workshop, name: 'Rails 101', attendees: 1, status: :active)
    workshop.enrollments.create(attendee: attendee)

    login_as attendee
    visit workshop_path(workshop)
    click_on 'Desinscrever-se'

    expect(page).to have_content('Você se desinscreveu do workshop "Rails 101"')
  end

  context 'Attendee not enrolled on workshop' do
    scenario 'and cannot disenroll' do
      attendee = create(:attendee)
      workshop = create(:workshop, name: 'Rails 101', attendees: 1, status: :active)

      login_as attendee
      visit workshop_path(workshop)

      expect(page).not_to have_content('Desinscrever-se')
    end
  end

  context 'Attendee already enrolled on the waiting list to workshop' do
    scenario 'and cannot disenroll' do
      attendee = create(:attendee)
      workshop = create(:workshop, name: 'Rails 101', attendees: 1, status: :active)
      workshop.enrollments.create(attendee: attendee, status: :waiting_list)

      login_as attendee
      visit workshop_path(workshop)

      expect(page).not_to have_content('Desinscrever-se')
    end
  end
end
