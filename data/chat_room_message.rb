class ChatRoomMessage < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  def deliver
    # ChatRoomChannel.broadcast_to(self.chat_room, self)
    # ActionCable.server.broadcast("chat_room/#{self.chat_room.id}", self)
    ChatRoomJob.perform_later(self)
  end
end
