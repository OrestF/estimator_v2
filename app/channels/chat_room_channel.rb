class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    # room = ChatRoom.find params[:chat_room_id]
    # stream_for room

    # or
    stream_from "chat_room/#{params[:chat_room_id]}"
  end

  def receive(data)
    return unless ChatRoom.find(data['chat_room_id']).user_ids.include?(current_user.id.to_s)

    ChatRoomMessage.create!(
      chat_room_id: data['chat_room_id'],
      user_id: current_user.id,
      body: data['message']
    ).deliver
  end
end
