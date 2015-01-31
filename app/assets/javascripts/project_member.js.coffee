#=require comment

$(document).on "page:change", ->
  $("form.comment_new").bind "ajax:success", () ->
    window.location.reload()

  .bind "ajax:error", (xhr, res) ->
    $("textarea.content").siblings(".error-msg").html(res.responseJSON.messages.join(',')).show()