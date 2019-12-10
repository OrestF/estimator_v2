import {createConsumer} from "@rails/actioncable";

$(function () {
    $('[data-channel-subscribe="chat-room"]').each(function (index, chatRoom) {
        var $chatRoom = $(chatRoom);
        var $chatRoomDialog = $chatRoom.find('.chat-room-dialog');
        var chatRoomId = $chatRoom.data('chat-room-id');

        $chatRoomDialog.animate({scrollTop: $chatRoomDialog.prop("scrollHeight")}, 1000);

        var consumer = createConsumer();
        var subscription = consumer.subscriptions.create({
                channel: "ChatRoomChannel",
                chat_room_id: chatRoomId
            },
            {
                received: function (data) {
                    var content = $('[data-role="chat-message-template"]').children().clone(true, true);
                    content.find('[data-role="chat-message-body"]').text(data.body);
                    content.find('[data-role="chat-message-date"]').text(data.updated_at);
                    if (data.user_id == $chatRoom.data('current-user-id')) {
                        content.addClass('current-user');
                    }
                    $chatRoomDialog.append(content);
                    $chatRoomDialog.animate({scrollTop: $chatRoomDialog.prop("scrollHeight")}, 1000);
                },
                connected: function (data) {
                    console.log("ChatRoom connected: ", chatRoomId);
                },
                disconnected: function (data) {
                    console.log("ChatRoom disconnected: ", chatRoomId);
                }
            }
        );

        $chatRoom.on('submit', '#chat_room_submit', function(e) {
            var $form = $(this);
            subscription.send({chat_room_id: chatRoomId, message: $form.serializeArray()[0]['value']});

            e.preventDefault();
            $form.trigger('reset');
            $form.removeAttr('disabled');
        });
    });
});
