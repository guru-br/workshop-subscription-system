require 'rails_helper'

feature 'User sees all available workshops' do
  scenario 'when accessing /workshops' do
    user = User.create!(email: 'user@ruby.com.br', password: '12345678')
    workshop1 = Workshop.create!(name: 'SOLID',
                               short_description: 'SOLID na prática',
                               full_description: 'Você vai aprender SOLID mesmo',
                               workshop_date: Date.today + 2.months,
                               start_time: '12:00:00',
                               duration: 60,
                               attendees: 100
                               )

    workshop2 = Workshop.create!(name: 'Ruby on Rails',
                               short_description: 'Seu blog em 20 minutos com RoR',
                               full_description: 'Aprenda a fazer um blog com Ruby on Rails',
                               workshop_date: Date.today + 1.months,
                               start_time: '13:00:00',
                               duration: 30,
                               attendees: 50
                               )

    login_as user, scope: :user
    visit workshops_path

    expect(page).to have_content workshop1.name
    expect(page).to have_content workshop1.short_description
    expect(page).to have_content "#{workshop1.duration} minutos"
    expect(page).to have_content I18n.localize workshop1.workshop_date
    expect(page).to have_content '12:00'
    expect(page).to have_content workshop1.attendees

    expect(page).to have_content workshop2.name
    expect(page).to have_content workshop2.short_description
    expect(page).to have_content "#{workshop2.duration} minutos"
    expect(page).to have_content I18n.localize workshop2.workshop_date
    expect(page).to have_content '13:00'
    expect(page).to have_content workshop2.attendees
  end

  scenario 'and only the ones in the future when accessing /workshops' do
    user = User.create!(email: 'user@ruby.com.br', password: '12345678')
    workshop = Workshop.create!(name: 'SOLID',
                               short_description: 'SOLID na prática',
                               full_description: 'Você vai aprender SOLID mesmo',
                               workshop_date: Date.today + 2.months,
                               start_time: '12:00:00',
                               duration: 60,
                               attendees: 100
                               )

    past_workshop = Workshop.create!(name: 'De volta para o futuro',
                                     short_description: 'Esse workshop já aconteceu',
                                     full_description: 'Por isso você não vai vê-lo no index',
                                     workshop_date: Date.today - 1.months,
                                     start_time: '12:00:00',
                                     duration: 30,
                                     attendees: 10
                                    )

    login_as user, scope: :user
    visit workshops_path

    expect(page).to have_content workshop.name
    expect(page).to have_content workshop.short_description

    expect(page).not_to have_content past_workshop.name
    expect(page).not_to have_content past_workshop.short_description
  end
end
