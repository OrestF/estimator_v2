FactoryBot.define do
  factory :feature do
    title { Faker::App.name }
    description { Faker::Lorem.sentence }
    acceptance_criteria { Faker::Lorem.sentence }
    specification { nil }
    user { nil }
  end
end
