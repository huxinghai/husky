$(document).on "page:update", ->
  new UE.ui.Editor({initialFrameHeight: 320}).render("project_description")

  $hp = $('.hours_price')
  template = $(".row_hours_price").html()
  $atta_list = $(".attachments table")
  project_atta_key = "project_attachnents"

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
          <input type='hidden' name='attachments[]' value='#{atta.id}' />
          #{atta.url}</td>
        <td><a href='javascript:;'><i class='fa fa-trash-o btn_trash'></i></a></td>
      </tr>
    ")

    $atta_list.removeClass("hide")


  addStorage = (key, data) ->
    items = getStorage(key)
    items.push(data)
    $.jStorage.set(key, items)

  getStorage = (key) ->
    $.jStorage.get(key) || []


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
    
  new qq.FileUploader(
    element: $(".form_new_project .file_upload .qq")[0],
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
      addStorage(project_atta_key, atta)
      addAttaRow(atta)
  )

  $atta_list.on "click", ".btn_trash", ->
    if confirm("是否确认移除?")
      $(this).closest("tr").remove()
      $.jStorage.deleteKey(project_atta_key)

  (->
    rows = getStorage(project_atta_key)
    for row in rows
      addAttaRow(row)
  )()
