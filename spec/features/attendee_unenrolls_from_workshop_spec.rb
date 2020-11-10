# frozen_string_literal: true

require 'rails_helper'

feature 'Attendee unenrolls from workshop' do
  scenario 'successfully' do
    attendee = create(:attendee)
    enrolled_attendee = create(:attendee)
    workshop = create(:workshop, name: 'Rails 101', attendees: 1, status: :active)
    workshop.enrollments.create(attendee: enrolled_attendee)

    login_as attendee
    visit workshop_path(workshop)
    click_on 'Cancelar inscrição'

    expect(page).to have_content('Inscrição cancelada do workshop "Rails 101"')
    expect(workshop.enrollments.count).to eq(0)
    expect(attendee.enrollments.count).to eq(0)
  end

  context 'Attendee not enrolled on workshop' do
    scenario 'and cannot unenroll from workshop' do
      attendee = create(:attendee)
      workshop = create(:workshop, name: 'Rails 101', attendees: 1, status: :active)

      login_as attendee
      visit workshop_path(workshop)
      click_on 'Cancelar inscrição'

      expect(page).to have_content('Você não está inscrito no workshop "Rails 101"')
      expect(page).not_to have_content('Inscrição cancelada do workshop "Rails 101"')
    end
  end
end
