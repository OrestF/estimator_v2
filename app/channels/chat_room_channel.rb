class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    # room = ChatRoom.find params[:chat_room_id]
    # stream_for room

    # or
    stream_from "chat_room/#{params[:chat_room_id]}"
  end
end
