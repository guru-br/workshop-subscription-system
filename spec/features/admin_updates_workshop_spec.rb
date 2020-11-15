# frozen_string_literal: true

require 'rails_helper'

feature 'Admin updates workshop' do
  scenario 'successfully' do
    workshop = create(:workshop)
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on I18n.t('home.index.list_workshops')
    click_on I18n.t('workshops.index.edit')
    select I18n.t('workshops.status.active'), from: 'workshop[status]'
    click_on I18n.t('workshops.edit.submit')

    expect(page).to have_content(I18n.t('workshops.notices.edit.success',
                                        name: workshop.name))
  end

  context 'must be signed in' do
    scenario 'to view edit form' do
      workshop = create(:workshop)

      visit edit_workshop_path(workshop)

      expect(current_path).to eq new_user_session_path
    end
  end
end
