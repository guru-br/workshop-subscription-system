# frozen_string_literal: true

FactoryBot.define do
  factory :workshop do
    name { 'Meu Workshop' }
    short_description  { FFaker::Lorem.sentence }
    full_description { FFaker::Lorem.paragraph(10) }
    attendees { 50 }
    duration { 30 }
    workshop_date { 10.days.from_now }
    start_time { Time.zone.now.to_s(:time) }
  end
end
