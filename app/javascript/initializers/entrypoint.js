$( document ).on('turbolinks:load ready', function() {
    $('.select2-js').not('.select2-hidden-accessible').select2({
        width: '100%'
    });

    initRecordToggleSwitch();
});

function initRecordToggleSwitch() {
    $(document).on('change', '.record-toggle input', function () {
        var $input = $(this);
        var $path = $input.parent('.record-toggle').data('path');
        $.ajax({
            type: "PATCH",
            url: $path,
            dataType: 'json',
        })
            .always( function(response) {
                window.location.reload();
                // $('#total_optimistic').text(response.specification.total_optimistic);
                // $('#total_pessimistic').text(response.specification.total_pessimistic);
            })

    })
}
