$( document ).on('turbolinks:load ready', function() {
    $('.select2-js').not('.select2-hidden-accessible').select2({
        width: '100%'
    });
});
