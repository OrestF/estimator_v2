$( document ).on('turbolinks:load ready', function() {
    if ($('#estimations-reports-datatable_wrapper').length == 0 ) {
        $('#estimations-reports-datatable').dataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": $('#estimations-reports-datatable').data('source')
            },
            "pagingType": "full_numbers",
            "columns": [
                {"data": "id"},
                {"data": "title"},
                {"data": "project"},
                {"data": "user"},
                {"data": "deadline"},
                {"data": "actions", "orderable": false},
            ]
        });
    }
});
