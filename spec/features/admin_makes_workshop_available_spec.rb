require 'rails_helper'

feature 'Admin makes workshop available for enrollment' do
	scenario 'successfully' do
		# Arrange
		user = User.create!(email: 'user@ruby.com.br', password: '12345678')
		workshop = Workshop.create!(
			name: 'Tutorial Ruby',
			short_description: 'Tutorial básico Ruby',
			full_description: 'Tutorial básico Ruby para iniciantes',
			duration: '120',
			workshop_date: Date.today + 3,
			start_time: '14:00',
			attendees: 50
		)

		# Act
		login_as user, scope: :user
		visit workshop_path(workshop)
		within '#event_status' do
			click_on 'Tornar Workshop Disponível'
		end

		# Assert
		expect(page).to have_content 'Workshop atualizado com sucesso'
		expect(page).to have_content 'Ativo'
		expect(page).not_to have_content 'Rascunho'
		expect(page).not_to have_button 'Tornar Workshop Disponível'
	end
end

