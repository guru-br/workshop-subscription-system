require 'rails_helper'

feature 'Admin register workshop' do
  scenario 'successfully' do
    # Arrange
    admin = User.create!(email: 'user@ruby.com.br', password: '12345678')
    # Act
    login_as admin
    visit root_path
    click_on 'Registrar Workshop'

    fill_in 'Nome', with: 'SOLID'
    fill_in 'Descrição Curta', with: 'Um workshop sobre SOLID na prática'
    fill_in 'Descrição Completa', with: 'Este workshop vai apresentar SOLID ' \
                                        'na prática'

    fill_in 'Capacidade Máxima', with: '100'
    fill_in 'Duração', with: '60'
    click_on 'Registrar'

    # Assert
    expect(page).to have_content 'Workshop registrado com sucesso'
    expect(page).to have_css('h1', text: 'SOLID')
    expect(page).to have_content 'Um workshop sobre SOLID na prática'
    expect(page).to have_content 'Este workshop vai apresentar SOLID ' \
                                 'na prática'
    expect(page).to have_content '60 minutos'
  end

  xscenario 'with empty fields' do
  end
end
