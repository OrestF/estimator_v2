$( document ).on('turbolinks:load ready', function() {
    $('#estimations-datatable').dataTable({
        "processing": true,
        "serverSide": true,
        "ajax": {
            "url": $('#estimations-datatable').data('source')
        },
        "pagingType": "full_numbers",
        "columns": [
            {"data": "id"},
            {"data": "project"},
            {"data": "title"},
            {"data": "state"},
            {"data": "actions", "orderable": false},
        ]
    });
});
