#=require comment

$(document).on "page:change", ->
  $("form.comment_new").bind "ajax:success", () ->
    debugger
  .bind "ajax:error", ->
    debugger