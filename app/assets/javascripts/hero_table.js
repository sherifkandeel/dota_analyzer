function filter_table () {
  var checkboxes = document.getElementsByTagName('input')
  var cells = document.getElementsByName('cell')
  var choices = []
  for(var i=0; i<checkboxes.length; i++)
    if(checkboxes[i].checked)
      choices.push(checkboxes[i])
  for(var i=0; i<cells.length; i++)
    for(var j=0; j<checkboxes.length; j++)
      if(cells[i].id == checkboxes[j].name) 
        cells[i].style.display = (checkboxes[j].checked || choices.length == 0)? '' : 'none'
}
