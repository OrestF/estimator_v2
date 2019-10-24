FactoryBot.define do
  factory :estimation_task do
    task { nil }
    estimation { nil }
    description { 'MyText' }
    optimistic { 1 }
    pessimistic { 1 }
  end
end
