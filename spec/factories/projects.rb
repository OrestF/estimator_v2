FactoryBot.define do
  factory :project do
    title { Faker::Book.title }
    description { Faker::Lorem.sentence }
  end
end
