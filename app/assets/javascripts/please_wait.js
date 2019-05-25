function add_please_wait() {
  var elems = document.body.getElementsByTagName("*")
  for(var i=0;i<elems.length-1;i++)
    if(elems[i].id != 'spinner' || elems[i].id != 'wait')
      elems[i].style.display = "none";
  document.getElementById("spinner").style.display = "block";
  document.getElementById("loading").style.display = "block";
}