//= require lib/jquery.timeago
//= require lib/jquery.timeago-zh


$(document).on("page:change", function(){
  $(function(){
    $("abbr.timeago").timeago();    
  })
})
