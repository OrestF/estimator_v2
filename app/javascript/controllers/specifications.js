$( document ).on('turbolinks:load ready', function() {
    $(document).on('change', ".feature_form:not(.create_form) input[name^=\'feature\'], .feature_form:not(.create_form) textarea[name^=\'feature\']", function () {
        submitRemoteForm($(this).parents('form').first())
    })
});


function submitRemoteForm($form) {
    $.ajax({
        type: "POST",
        url: $form.attr('action'),
        data: $form.serialize(),
        dataType: 'script',
        always: function(response) {
            console.log(response)
        }
    });
}
