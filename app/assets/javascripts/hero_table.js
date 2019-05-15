function filter_table () {
  var table = $('#hero_table').DataTable(), index = 2 * (table.column(1).header().title == 'Your Pick')
  var inputs = document.getElementsByTagName('input')
  var checkboxes = [] , checked = 0
  for(var i=0; i<inputs.length; i++)
    if(inputs[i].type == 'checkbox')
      checkboxes.push(inputs[i]), checked += inputs[i].checked
  for(var j=0; j<checkboxes.length; j++)
    for(var i=1; i<17+index; i++)
      if(table.column(i).header().title.includes(checkboxes[j].name)) 
        table.column(i).visible(checkboxes[j].checked || checked == 0) 
}
