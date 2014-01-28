jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $( "#datepicker" ).datepicker( "option", "dateFormat", $( this ).val() )
