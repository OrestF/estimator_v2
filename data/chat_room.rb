class ChatRoom < ApplicationRecord
  belongs_to :chatable, polymorphic: true

  has_many :chat_room_messages
end
