FactoryBot.define do
  factory :estimation do
    title { Faker::Book.title }
    user { nil }
    specification { nil }
  end
end
