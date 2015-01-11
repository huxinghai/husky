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
    return show_error_msg("请输入金额!") if $.isEmptyObject(price)
    return show_error_msg("请输入正确的金额!") unless $.isNumeric(price)

    type = $.trim($(".btn_bar", $hp).attr('data-selected'))
    unless $.isEmptyObject(type)
      $(".bar", $hp).removeClass("has-error")
      $input.tooltip("hide")
      renderTemplate(type: type, price: price)

  renderTemplate = (opts) ->
    t = $(template)
    $("td:eq(0)", t).attr("data-type-value", opts.type).html("1/#{listPriceType[opts.type]}")
    $("td:eq(1)", t).attr("data-price-value", opts.price).html(opts.price)
    $(".addItems>tbody", $hp).append(t)

    # $("input:text").validationEngine('showPrompt', 'This a custom msg', 'load');



