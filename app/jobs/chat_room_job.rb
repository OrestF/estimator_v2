class ChatRoomJob < ApplicationJob
  queue_as :chat_rooms

  def perform(chat_message)
    ActionCable.server.broadcast("chat_room/#{chat_message.chat_room.id}", chat_message)
  end
end
