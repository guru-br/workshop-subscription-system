require 'rails_helper'

feature 'Admin view workshop attendees list' do
  scenario 'workshop has no attendees' do
    workshop = create(:workshop)
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on I18n.t('home.index.list_workshops')
    click_on I18n.t('workshops.index.show')

    expect(page).to have_content('Nenhum participante inscrito')
  end
  scenario 'workshop has one attendee' do
    user = create(:user)
    attendee = create(:attendee)
    workshop = create(:workshop, name: 'Rails 101', attendees: 1, status: :active)
    workshop.enrollments.create(attendee: attendee)

    login_as user, scope: :user
    visit root_path
    click_on I18n.t('home.index.list_workshops')
    click_on I18n.t('workshops.index.show')

    expect(page).to have_content(attendee.name)
  end
end
