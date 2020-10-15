require 'rails_helper'

feature 'Admin register workshop' do
  scenario 'successfully' do
    # Arrange
    user = User.create!(email: 'user@ruby.com.br', password: '12345678')
    # Act
    login_as user
    visit root_path
    click_on 'Registrar Workshop'

    fill_in 'Nome', with: 'SOLID'
    fill_in 'Descrição Curta', with: 'Um workshop sobre SOLID na prática'
    fill_in 'Descrição Completa', with: 'Este workshop vai apresentar SOLID ' \
                                        'na prática'

    fill_in 'Capacidade Máxima', with: '100'
    fill_in 'Data', with: '05/12/2020'
    fill_in 'Hora', with: '14:00'
    fill_in 'Duração', with: '60'
    click_on 'Registrar'

    # Assert
    expect(page).to have_content 'Workshop registrado com sucesso'
    expect(page).to have_css('h1', text: 'SOLID')
    expect(page).to have_content 'Um workshop sobre SOLID na prática'
    expect(page).to have_content 'Este workshop vai apresentar SOLID ' \
                                 'na prática'
    expect(page).to have_content '60 minutos'
    expect(page).to have_content '05/12/2020'
    expect(page).to have_css('dd', text: /^14:00$/ )
  end

  context 'must be signed in' do

    scenario 'to view link' do
      visit root_path

      expect(page).not_to have_link('Registrar Workshop')
    end

    scenario 'to view form' do
      visit new_workshop_path

      expect(current_path).to eq new_user_session_path
    end
  end
end
