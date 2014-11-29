$ ->

  $(document).on "submit", ".user_edit_password form.edit", (e) ->
    e.preventDefault();
    user_id = $("input.user_id", this).val();
    $msg_success = $(".msg-success", this)
    $msg_error = $(".msg-error", this)
    that = this;

    $.ajax
      url: "/members/#{user_id}/change_password"
      type: "put"
      dataType: 'json'
      data: $(this).serialize();
      success: () ->
        $msg_success.html("更改成功！");
        $msg_success.removeClass("hide");
        $msg_error.addClass("hide");
        that.reset();

      error: (xhr) ->        
        try
          msg = JSON.parse(xhr.responseText)
          $msg_error.html(msg.messages)
        catch e
          $msg_error.html(xhr.responseText)
        $msg_success.addClass("hide")
        $msg_error.removeClass("hide");
              
