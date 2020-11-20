# frozen_string_literal: true

require 'rails_helper'

feature 'Attendee unenrolls from workshop' do
  scenario 'successfully' do
    attendee = create(:attendee)
    enrolled_attendee = create(:attendee)
    workshop = create(:workshop, name: 'Rails 101', attendees: 10, status: :active)
    enrollment = create(:enrollment, workshop: workshop, attendee: enrolled_attendee)

    login_as enrolled_attendee
    visit workshop_path(workshop)
    click_on 'Cancelar inscrição'

    expect(page).to have_content('Inscrição no workshop "Rails 101" cancelada com sucesso')
    expect(workshop.enrollments.count).to eq(0)
    expect(enrolled_attendee.enrollments.count).to eq(0)
  end

  context 'Attendee not enrolled on workshop' do
    scenario 'and cannot unenroll from workshop' do
      attendee = create(:attendee)
      workshop = create(:workshop, name: 'Rails 101', attendees: 10, status: :active)

      login_as attendee
      visit workshop_path(workshop)

      expect(page).not_to have_button('Cancelar inscrição')
    end
  end
end
