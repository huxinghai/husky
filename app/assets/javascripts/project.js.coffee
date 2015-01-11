$(document).on "page:update", ->
  new UE.ui.Editor({initialFrameHeight: 320}).render("project_description")

  $hp = $('.hours_price')
  template = $(".row_hours_price").html()

  $hp.on "click", "ul.dropdown-menu>li", (e) ->
    e.preventDefault()
    li = $(e.currentTarget)
    $(".btn_bar", $hp).attr("data-selected", li.attr("data-value"))
    $(".btn_bar .content", $hp).html(li.find("a").html())


  listPriceType = {
    "h": "时",
    "d": "天",
    "w": "周",
    "m": "月",
    "u": '不固定'
  }

  $hp.on "click", ".btn_add", (e) ->
    e.preventDefault()

    $input = $("input:text", $hp)

    show_error_msg = (msg) ->
      $(".bar", $hp).addClass("has-error")
      $input.tooltip({
        title: msg,
        trigger: "manual",
        msg_type: "danger"
      }).tooltip('show');

    price = $.trim($input.val())
    type = $.trim($(".btn_bar", $hp).attr('data-selected'))

    return show_error_msg("请输入金额!") if $.isEmptyObject(price)
    return show_error_msg("请输入正确的金额!") unless $.isNumeric(price)
    return show_error_msg("已经存在这种时薪!") if validExists(type)
    
    unless $.isEmptyObject(type)
      $(".bar", $hp).removeClass("has-error")
      $input.tooltip("hide")
      renderTemplate(type: type, price: price)
      $input.val('');

  validExists = (type) ->
    $(".add_items>tbody td[data-type-value=#{type}]", $hp).length > 0

  renderTemplate = (opts) ->
    t = $(template)
    $("td:eq(0)", t).attr("data-type-value", opts.type).html("1/#{listPriceType[opts.type]}")
    $("td:eq(1) .price", t).attr("data-price-value", opts.price).html(opts.price)
    $(".add_items>tbody", $hp).append(t)
    $(".add_items", $hp).removeClass("hide")

  $(".add_items", $hp).on "click", ".btn_trash", (e) ->
    e.preventDefault()
    $(this).closest("tr").remove()

    $(".add_items", $hp).addClass("hide") if $(".add_items>tbody tr").length <= 0


  # addStorage = (data) ->
  #   items = getStorage()
  #   items.push(data)
  #   $.jStorage.set("project_new_price", items, {TTL: 86400})

  # getStorage = () ->
  #   $.jStorage.get("project_new_price") || []

