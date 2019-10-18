FactoryBot.define do
  factory :estimation do
    title { Faker::Book.title }
    project { nil }
    user { nil }
  end
end
