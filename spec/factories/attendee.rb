FactoryBot.define do
  factory :attendee do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    name { FFaker::Name.first_name }
  end
end
