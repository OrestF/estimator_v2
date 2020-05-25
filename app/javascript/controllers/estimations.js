$( document ).on('turbolinks:load ready', function() {
    $(document).on('change', ".estimation_task_form:not(.create_form) input[name^=\'estimation_task\']", function () {
        submitRemoteForm($(this).parents('form').first())
    });

    $('.rename-estimation-form').on('submit', function (e) {
        e.stopPropagation();
        e.preventDefault();

        submitRenameEstimationForm($(this))
    });

    $(document).on('click', '.rename-estimation-btn', function (e) {
        e.preventDefault();
        e.stopPropagation();
        var $form = $(this).siblings('form');

        $form.toggle();
        $form.parents('.list-group-item').find('.estimation-title').toggle();
    });
});

function submitRemoteForm($form) {
    $.ajax({
        type: "POST",
        url: $form.attr('action'),
        data: $form.serialize(),
        dataType: 'script',
    });
}


function submitRenameEstimationForm($form) {
    console.log('submitRenameEstimationForm');
    $.ajax({
        type: "POST",
        url: $form.attr('action'),
        data: $form.serialize(),
        dataType: 'json',
    })
      .always( function(response) {
        $form.parents('.list-group-item').find('.estimation-title').html(response.dc_title).toggle();
        $form.toggle();
      })
}