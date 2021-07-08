require 'rails_helper'

feature ' Attendee enrolls on workshop' do
  scenario 'and review' do
    workshop = create(:workshop, status: :active, attendees: 10, 
                                 name: 'Workshop de TDD', 
                                 workshop_date: '2020-10-05',
                                 start_time: '14:00')
    attendee = create(:attendee, name: 'José Silva')

    login_as attendee
    visit workshop_path(workshop)
    click_on 'Inscrever-me'

    expect(page).to have_css('h1', text: 'Confirmar Inscrição?')
    expect(page).to have_css('p', text: 'Verifique os dados do workshop antes de confirmar sua inscrição')
    expect(page).to have_content 'Workshop de TDD'
    expect(page).to have_content workshop.full_description
    expect(page).to have_content "#{workshop.duration} minutos"
    expect(page).to have_content '05/12/2020'
    expect(page).to have_css('dd', text: /^14:00$/)
  end

  scenario 'and review' do
    workshop = create(:workshop, status: :active, attendees: 10, 
                                 name: 'Workshop de TDD', 
                                 workshop_date: '2020-10-05',
                                 start_time: '14:00')
    attendee = create(:attendee, name: 'José Silva')

    login_as attendee
    visit workshop_path(workshop)
    click_on 'Inscrever-me'
    click_on 'Sim, confirmar minha inscrição'

    enrollment = Enrollment.last
    expect(page).to have_content 'Inscrição confirmada'
    expect(page).to have_content enrollment.verification_code
  end


  scenario 'cannot enroll twice' do
    workshop = create(:workshop, status: :active, attendees: 10, 
                                 name: 'Workshop de TDD', 
                                 workshop_date: '2020-10-05',
                                 start_time: '14:00')
    attendee = create(:attendee, name: 'José Silva')
    enrollment = create(:enrollment, workshop: workshop, attendee: attendee)

    login_as attendee
    visit workshop_path(workshop)

    expect(page).not_to have_link('Inscrever-me')
  end

  scenario 'if past' do
    
  end

  scenario 'if capacity full' do
    
  end

  scenario 'if draft' do
    
  end
end