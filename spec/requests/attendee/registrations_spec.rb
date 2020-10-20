# frozen_string_literal: true

require 'rails_helper'

describe 'attendee /devise/registrations' do
  describe 'request new_attendee_registration' do
    context 'when has valid params' do
      before do
        visit new_attendee_registration_path

        fill_in I18n.t('activerecord.attributes.attendee.name'),
                with: 'new user'
        fill_in I18n.t('activerecord.attributes.attendee.email'),
                with: 'user@example.com'
        fill_in I18n.t('activerecord.attributes.attendee.password'),
                with: 'pass123'
        fill_in I18n.t('activerecord.attributes.attendee.password_confirmation'),
                with: 'pass123'

        click_button I18n.t('actions.sign_up')
      end

      it 'record new attendee correctly', :aggregate_failures do
        expect(Attendee.last.attributes).to include(
          { name: 'new user',
            email: 'user@example.com' }.stringify_keys
        )
      end

      it 'redirect to "/"', :aggregate_failures do
        expect(page).to have_current_path('/')
        expect(page)
          .to have_content I18n.t('devise.registrations.signed_up')
      end
    end

    context 'when has invalid params' do
      before do
        visit new_attendee_registration_path

        fill_in I18n.t('activerecord.attributes.attendee.name'),
                with: nil
        fill_in I18n.t('activerecord.attributes.attendee.email'),
                with: nil
        fill_in I18n.t('activerecord.attributes.attendee.password'),
                with: nil
        fill_in I18n.t('activerecord.attributes.attendee.password_confirmation'),
                with: nil

        click_button I18n.t('actions.sign_up')
      end

      it 'don\'t record new attendee' do
        expect(Attendee.count).to eq 0
      end

      it 'redirect page to "/attendees"', :aggregate_failures do
        expect(page).to have_current_path('/attendees')
        expect(page)
          .to_not have_content I18n.t('devise.registrations.signed_up')
      end
    end
  end
end
