document.addEventListener("turbolinks:load", function () {
  $('#hero_table').DataTable({
    "paging":   true,
    "retrieve": true,
    "autoWidth": false,
    "scrollX": true,
    "lengthMenu": [[20, 40, 50,  100,-1], [20, 40, 50, 100, "All"]],
    "columnDefs": [{ type: 'num-html', targets: '_all' }]
  })
});
$(window).on('resize', function (event) {
  $('#hero_table').DataTable().columns.adjust().draw( false );
});