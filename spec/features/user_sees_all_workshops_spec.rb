# frozen_string_literal: true

require 'rails_helper'

feature 'User sees all available workshops' do
  scenario 'when accessing /workshops' do
    user = User.create!(email: 'user@ruby.com.br', password: '12345678')
    workshop1 = create(:workshop, start_time: Time.zone.now)
    workshop2 = create(:workshop, start_time: Time.zone.now)

    login_as user, scope: :user
    visit workshops_path

    expect(page).to have_content workshop1.name
    expect(page).to have_content workshop1.short_description
    expect(page).to have_content "#{workshop1.duration} minutos"
    expect(page).to have_content I18n.localize workshop1.workshop_date
    expect(page).to have_content I18n.localize workshop1.start_time,
                                               format: :short
    expect(page).to have_content workshop1.attendees

    expect(page).to have_content workshop2.name
    expect(page).to have_content workshop2.short_description
    expect(page).to have_content "#{workshop2.duration} minutos"
    expect(page).to have_content I18n.localize workshop2.workshop_date
    expect(page).to have_content I18n.localize workshop2.start_time,
                                               format: :short
    expect(page).to have_content workshop2.attendees
  end

  scenario 'and only the ones in the future when accessing /workshops' do
    user = User.create!(email: 'user@ruby.com.br', password: '12345678')
    workshop = create(:workshop)
    past_workshop = create(:workshop, workshop_date: Time.zone.today - 1.month,
                                      name: 'Outro')

    login_as user, scope: :user
    visit workshops_path

    expect(page).to have_content workshop.name
    expect(page).to have_content workshop.short_description

    expect(page).not_to have_content past_workshop.name
    expect(page).not_to have_content past_workshop.short_description
  end
end
