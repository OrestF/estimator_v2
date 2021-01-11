$( document ).on('turbolinks:load ready', function() {
    if ($('#projects-datatable_wrapper').length == 0 ) {
        $('#projects-datatable').dataTable({
            "order": [[ 0, "desc" ]],
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": $('#projects-datatable').data('source')
            },
            "pagingType": "full_numbers",
            "columns": [
                {"data": "id"},
                {"data": "title"},
                {"data": "domain"},
                {"data": "state"},
                {"data": "user"},
                {"data": "client"},
                {"data": "actions", "orderable": false},
            ]
        });
    }
});
