import {createConsumer} from "@rails/actioncable";

$(function () {
    $('[data-channel-subscribe="chat-room"]').each(function (index, chatRoom) {
        var $chatRoom = $(chatRoom);
        var messageTemplate = $('[data-role="message-template"]');
        var chatRoomId = $chatRoom.data('chat-room-id')

        $chatRoom.animate({scrollTop: $chatRoom.prop("scrollHeight")}, 1000)

        createConsumer().subscriptions.create({
                channel: "ChatRoomChannel",
                chat_room_id: chatRoomId
            },
            {
                received: function (data) {
                    var content = messageTemplate.children().clone(true, true);
                    content.find('[data-role="message-body"]').text(data.body);
                    content.find('[data-role="message-date"]').text(data.updated_at);
                    $chatRoom.append(content);
                    $chatRoom.animate({scrollTop: $chatRoom.prop("scrollHeight")}, 1000);
                },
                connected: function (data) {
                    console.log("ChatRoom connected: ", chatRoomId);
                },
                disconnected: function (data) {
                    console.log("ChatRoom disconnected: ", chatRoomId);
                }
            }
        );
    });
});
