FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    role { 'worker' }
    organization { create(:organization) }
  end
end
