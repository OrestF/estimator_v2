FactoryBot.define do
  factory :chat_room_message do
    chat_room { nil }
    body { 'MyText' }
    user { nil }
  end
end
