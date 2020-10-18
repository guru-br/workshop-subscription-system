require 'rails_helper'

feature 'Admin views Workshop' do
  context 'regardless of Workshop status' do
    scenario 'when Workshop is a draft' do
      # Arrange
      user = User.create!(email: 'user@ruby.com.br', password: '12345678')
      workshop = Workshop.create!(
        name: 'Design Patterns com Ruby',
        short_description: 'Utilizando Design Patterns com Ruby',
        full_description: 'Utilizando Design Patterns com Ruby com exemplos do mundo real',
        duration: '120',
        workshop_date: Date.today + 5,
        start_time: '14:00',
        attendees: 20,
        status: :draft
      )

      # Act
      login_as user, scope: :user
      visit workshop_path(workshop)

      # Assert
      expect(page).to have_content workshop.name
      expect(page).to have_content 'Rascunho'
    end

    scenario 'when Workshop is active' do
      # Arrange
      user = User.create!(email: 'user@ruby.com.br', password: '12345678')
      workshop = Workshop.create!(
        name: 'Design Patterns com Ruby',
        short_description: 'Utilizando Design Patterns com Ruby',
        full_description: 'Utilizando Design Patterns com Ruby com exemplos do mundo real',
        duration: '120',
        workshop_date: Date.today + 5,
        start_time: '14:00',
        attendees: 20,
        status: :active
      )

      # Act
      login_as user, scope: :user
      visit workshop_path(workshop)

      # Assert
      expect(page).to have_content workshop.name
      expect(page).to have_content 'Ativo'
    end

    scenario 'when Workshop is inactive' do
      # Arrange
      user = User.create!(email: 'user@ruby.com.br', password: '12345678')
      workshop = Workshop.create!(
        name: 'Design Patterns com Ruby',
        short_description: 'Utilizando Design Patterns com Ruby',
        full_description: 'Utilizando Design Patterns com Ruby com exemplos do mundo real',
        duration: '120',
        workshop_date: Date.today + 5,
        start_time: '14:00',
        attendees: 20,
        status: :inactive
      )

      # Act
      login_as user, scope: :user
      visit workshop_path(workshop)

      # Assert
      expect(page).to have_content workshop.name
      expect(page).to have_content 'Inativo'
    end
  end
end

