FactoryBot.define do
  factory :estimation_task do
    estimation { nil }
    title { Faker::Book.title }
    description { Faker::Lorem.sentence }
    optimistic { rand(1..10) }
    pessimistic { rand(1..10) }
  end
end
