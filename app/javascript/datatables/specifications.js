$( document ).on('turbolinks:load ready', function() {
    if ($('#specifications-datatable_wrapper').length == 0 ) {
        $('#specifications-datatable').dataTable({
            "order": [[ 0, "desc" ]],
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": $('#specifications-datatable').data('source')
            },
            "pagingType": "full_numbers",
            "columns": [
                {"data": "id"},
                {"data": "title"},
                {"data": "project"},
                {"data": "user"},
                {"data": "deadline"},
                {"data": "state"},
                {"data": "actions", "orderable": false},
            ]
        });
    }
});
