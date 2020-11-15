# frozen_string_literal: true

require 'rails_helper'

feature 'Attendee enrolls to waiting list' do
  scenario 'successfully' do
    attendee = create(:attendee)
    enrolled_attendee = create(:attendee)
    workshop = create(:workshop, name: 'Rails 101', attendees: 1, status: :active)
    workshop.enrollments.create(attendee: enrolled_attendee)

    login_as attendee
    visit workshop_path(workshop)
    click_on 'Inscrever-se na lista de espera'

    expect(page).to have_content('Você se inscreveu na lista de espera do workshop "Rails 101"')
  end

  context 'Attendee already enrolled on workshop' do
    scenario 'and cannot enroll on the waiting list' do
      attendee = create(:attendee)
      workshop = create(:workshop, name: 'Rails 101', attendees: 1, status: :active)
      workshop.enrollments.create(attendee: attendee)

      login_as attendee
      visit workshop_path(workshop)
      click_on 'Inscrever-se na lista de espera'

      expect(page).to have_content('Você já está inscrito no workshop "Rails 101"')
      expect(page).not_to have_content('Você se inscreveu na lista de espera do workshop "Rails 101"')
    end
  end

  context 'Attendee already enrolled on the waiting list to workshop' do
    scenario 'and cannot enroll again' do
      attendee = create(:attendee)
      enrolled_attendee = create(:attendee)
      workshop = create(:workshop, name: 'Rails 101', attendees: 1, status: :active)
      workshop.enrollments.create(attendee: enrolled_attendee)
      workshop.enrollments.create(attendee: attendee, status: :waiting_list)

      login_as attendee
      visit workshop_path(workshop)
      click_on 'Inscrever-se na lista de espera'

      expect(page).to have_content('Você já está inscrito na lista de espera do workshop "Rails 101"')
      expect(page).not_to have_content('Você se inscreveu na lista de espera do workshop "Rails 101"')
    end
  end
end
