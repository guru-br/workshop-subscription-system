require 'rails_helper'

feature 'Unlogged user views Workshop' do
  context 'when Workshop is active' do
    scenario 'successfully' do
      # Arrange
      workshop = Workshop.create!(
        name: 'RSpec em 10 minutos',
        short_description: 'Aprenda RSpec em 10 minutos',
        full_description: 'Tutorial de RSpec com funcionamento básico',
        duration: '120',
        workshop_date: Date.today + 5,
        start_time: '16:00',
        attendees: 20,
        status: :active
      )

      # Act
      visit workshop_path(workshop)

      # Assert
      expect(page).to have_content workshop.name
      expect(page).to have_content workshop.full_description
    end
  end

  context 'when Workshop is in draft state' do
    scenario 'unlogged user gets redirected to home' do
      # Arrange
      workshop = Workshop.create!(
        name: 'RSpec em 10 minutos',
        short_description: 'Aprenda RSpec em 10 minutos',
        full_description: 'Tutorial de RSpec com funcionamento básico',
        duration: '120',
        workshop_date: Date.today + 5,
        start_time: '16:00',
        attendees: 20
      )

      # Act
      visit workshop_path(workshop)

      # Assert
      expect(page.current_path).to eq(root_path)
      expect(page).to have_content('Este workshop está indisponível')
    end
  end
end

