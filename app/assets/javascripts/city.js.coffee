$(document).on "page:update", ->
  items = $("[data-toggle=address]")
  items.each (i, item) ->
    $(item).on "change", "select.province", (e) ->
      $city = $("select.city", item)

      province_id = $.trim($(this).val())
      $city.html('')

      if not province_id? or province_id == ""
        return


      $.ajax
        url: "/address/#{province_id}/cities"
        dataType: "json"
        success: (data) ->
          $city.html('')
          for a  in data
            $city.append("<option value='#{a.id}'>#{a.name}</option>")

        error: (xhr) ->
          console.error(xhr.responseText);


