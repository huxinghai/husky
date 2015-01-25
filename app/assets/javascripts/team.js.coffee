$(document).on "page:change", ->
  new UE.ui.Editor({initialFrameHeight: 220}).render("team_description")

$ ->
  $('form#invitation')
  .bind 'ajax:success', (data, status, xhr) ->
    $(".flash-message").html("邀请成功。。。").show()
  .bind 'ajax:error', (xhr, status, error) ->
    $(".flash-message").html("邀请失败").show()