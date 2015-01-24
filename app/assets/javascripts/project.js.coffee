$(document).on "page:update", ->
  new UE.ui.Editor({initialFrameHeight: 320}).render("project_description")

  $hp = $('.hours_price')
  template = $(".row_hours_price").html()
  $atta_list = $(".attachments table")
  $form = $(".form_new_project")

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

  addAttaRow = (atta) ->
    $("tbody", $atta_list).append("
      <tr>
        <td>
          <input type='hidden' name='project[attachment_ids][]' value='#{atta.id}' />
          #{atta.url}</td>
        <td><a href='javascript:;'><i class='fa fa-trash-o btn_trash'></i></a></td>
      </tr>
    ")

    $atta_list.removeClass("hide")


  addStorage = (key, data, s = true) ->
    if s 
      items = getStorage(key)
      items.push(data)
    else
      items = [data]

    $.jStorage.set(key, items)

  getStorage = (key) ->
    $.jStorage.get(key) || []

  removeStorage = (key, k, v) ->
    items = getStorage(key)
    for item, i in items
      items.splice(i, 1) if item && item[k] == v

    $.jStorage.set(key, items)


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
      addStorage(cache_key.hprices, {type: type, price: price})

  validExists = (type) ->
    $(".add_items>tbody td[data-type-value=#{type}]", $hp).length > 0

  renderTemplate = (opts) ->
    t = $(template)
    $("td:eq(0)", t).attr("data-type-value", opts.type).html("1/#{listPriceType[opts.type]}")
    $("td:eq(1) .price", t).attr("data-price-value", opts.price).html(opts.price)
    $(".add_items>tbody", $hp).append(t)
    $("input.price", t).attr("name", "project[budget_list][#{opts.type}]").val(opts.price)
    $(".add_items", $hp).removeClass("hide")

  $(".add_items", $hp).on "click", ".btn_trash", (e) ->
    e.preventDefault()
    tr = $(this).closest("tr")
    tr.remove()
    removeStorage(cache_key.hprices, "type", $("input.type", tr).val())

    $(".add_items", $hp).addClass("hide") if $(".add_items>tbody tr").length <= 0
    
  new qq.FileUploader(
    element: $(".file_upload .qq", $form)[0],
    name: "avatar",
    action: "/projects/upload",
    debug: true,
    sizeLimit: 62914560,
    params: {
      authenticity_token: $("[name=csrf-token]").attr("content")
    },
    uploadButtonText: "",
    onComplete: (id, filename, result) ->
      atta = {id: result.id, url: result.file.url}
      addStorage(cache_key.atta, atta)
      addAttaRow(atta)
  )

  $atta_list.on "click", ".btn_trash", ->
    if confirm("是否确认移除?")
      tr = $(this).closest("tr")
      id = tr.find("input:hidden").val()
      tr.remove()
      removeStorage(cache_key.atta, "id", parseInt($("input:hidden", tr).val()))
      $.ajax
        url: "/attachments/#{id}",
        type: "delete",
        dataType: "json",
        success: ->

  $ul = $("ul.price_type")
  $ul.on "click", "li", (e) ->
    e.preventDefault()
    index = $(">li", $ul).index($(this))
    addStorage(cache_key.price_type, index, false)
    $("input.project_price_type", $ul).val($("a", this).attr("aria-controls"))


  $form.on "keyup", "input.budget", ->
    val = $.trim($(this).val())
    addStorage(cache_key.money, val, false) unless $.isEmptyObject(val)
  .on "change", "select.category_id", ->
    val = $.trim($(this).val())
    addStorage(cache_key.category, val, false) unless $.isEmptyObject(val)
  .on "keyup", "input.title", ->
    val = $.trim($(this).val())
    addStorage(cache_key.title, val, false) unless $.isEmptyObject(val)
  .on "keyup", "input.description", ->
    val = $.trim($(this).val())
    addStorage(cache_key.category, val, false) unless $.isEmptyObject(val)

  (->
    rows = getStorage(cache_key.atta)
    for row in rows
      addAttaRow(row)

    rows = getStorage(cache_key.hprices)
    for row in rows
      renderTemplate(row)

    rows = getStorage(cache_key.price_type)
    $("li:eq(#{rows[0]})>a", $ul).click() if rows.length > 0

    rows = getStorage(cache_key.money)
    $("input.budget", $form).val(rows[0]) if rows.length > 0

    rows = getStorage(cache_key.category)
    $("select.category_id", $form).val(rows[0]) if rows.length > 0

    rows = getStorage(cache_key.title)
    $("input.title", $form).val(rows[0]) if rows.length > 0

    rows = getStorage(cache_key.content)
    $("input.description", $form).val(rows[0]) if rows.length > 0
  )()
