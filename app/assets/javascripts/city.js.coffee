
$(document).on "page:update", ->
  
  items = $("[data-toggle=address]")
  items.each (i, item) ->

    $(item).on "change", "select.province",(e) ->

      province_id = $(this).val()
      $.ajax
        url: "/address/#{province_id}/cities"
        dataType: "json"
        success: (data) ->
          $city = $("select.city", item)
          $city.html('')
          for a  in data
            $city.append("<option value='#{a.id}'>#{a.name}</option>")

        error: (xhr) ->
          console.error(xhr.responseText);


