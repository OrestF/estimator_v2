FactoryBot.define do
  factory :estimation_report do
    title { Faker::Book.title }
    project { nil }
    user { nil }
    deadline { Faker::Time.forward }
  end
end
