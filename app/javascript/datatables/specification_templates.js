$( document ).on('turbolinks:load ready', function() {
    if ($('#specification-templates-datatable_wrapper').length == 0 ) {
        $('#specification-templates-datatable').dataTable({
            "order": [[ 0, "desc" ]],
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": $('#specification-templates-datatable').data('source')
            },
            "pagingType": "full_numbers",
            "columns": [
                {"data": "id"},
                {"data": "title"},
                {"data": "user"},
                {"data": "actions", "orderable": false},
            ]
        });
    }
});
