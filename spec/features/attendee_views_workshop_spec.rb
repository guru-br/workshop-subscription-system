# frozen_string_literal: true

require 'rails_helper'

feature 'Attendee views workshop' do
  scenario 'successfully' do
    workshop = create(:workshop, status: :active)
    attendee = create(:attendee)

    login_as attendee
    visit workshop_path(workshop)

    expect(current_path).to eq(workshop_path(workshop))
    expect(page).to have_content(workshop.name)
  end

  context 'workshop must not be a draft' do
    scenario 'to be viewed' do
      workshop = create(:workshop, status: :draft)
      attendee = create(:attendee)

      login_as attendee
      visit workshop_path(workshop)

      expect(current_path).to eq(root_path)
      expect(page).to have_content(I18n.t('workshops.notices.show.draft'))
    end
  end
end
