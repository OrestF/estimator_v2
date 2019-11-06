FactoryBot.define do
  factory :estimation do
    title { Faker::Book.title }
    user { nil }
    estimation_report { nil }
  end
end
