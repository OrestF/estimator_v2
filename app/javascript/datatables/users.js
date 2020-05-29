$( document ).on('turbolinks:load ready', function() {
    if ($('#users-datatable_wrapper').length == 0 ) {
        $('#users-datatable').dataTable({
            "order": [[ 0, "desc" ]],
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": $('#users-datatable').data('source')
            },
            "pagingType": "full_numbers",
            "columns": [
                {"data": "id"},
                {"data": "email"},
                {"data": "first_name"},
                {"data": "last_name"},
                {"data": "role"},
                {"data": "domain"},
                {"data": "experience_level"},
                {"data": "invitation_state"},
                {"data": "actions", "orderable": false},
            ]
        });
    }
});
