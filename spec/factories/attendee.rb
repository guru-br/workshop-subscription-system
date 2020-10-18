FactoryBot.define do
  factory :attendee do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
