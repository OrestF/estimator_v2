FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    role { 'worker' }
    domain { User.domains.keys.sample }
    organization { create(:organization) }
    password { 'password' }
  end
end
