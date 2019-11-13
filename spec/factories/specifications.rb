FactoryBot.define do
  factory :specification do
    title { Faker::Book.title }
    project { nil }
    user { nil }
    deadline { Faker::Time.forward }
  end
end
