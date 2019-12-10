class ChatRoomMessage < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  def deliver
    ChatRoomJob.perform_later(self)
  end
end
