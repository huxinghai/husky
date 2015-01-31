$(document).on "page:change", ->
  new UE.ui.Editor({initialFrameHeight: 320}).render("project_description")

  $hp = $('.wrap_budget')
  template = $(".row_hours_price").html()
  $atta_list = $(".attachments table")
  $form = $(".form_new_project")
  $category = $(".categories")
  $children = $(".children select", $category)

  showBudget = (value, text) ->
    $(".btn_bar", $hp).attr("data-selected", value)
    $(".btn_bar .content", $hp).html(text)
    $("input.budget_state", $hp).val(value)

  $hp.on "click", "ul.dropdown-menu>li", (e) ->
    e.preventDefault()
    li = $(e.currentTarget)
    showBudget(li.attr("data-value"), li.find("a").html())
    addStorage(cache_key.compute_type, {
      value: li.attr("data-value"), 
      text: li.find("a").html()
    }, false)

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

  validExists = (type) ->
    $(".add_items>tbody td[data-type-value=#{type}]", $hp).length > 0
    
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

  fetchChildren = (parent_id, callback) ->
    $.ajax
      url: "/categories/#{parent_id}/childrens"
      dataType: 'json'
      success: (data) ->
        $children.html("")
        $children.append("<option value=#{item.id}>#{item.name}</option>") for item in data

        callback() if callback
        rows = getStorage(cache_key.category)
        if rows.length > 0
          category_id = rows[0][parent_id]
          $children.val(category_id) if category_id
        $children.parent().show()

  $category.on "change", ">select", (e) ->
    e.preventDefault()
    val = $.trim($(this).val())
    if val then fetchChildren(val) else $children.parent().hide()

  $form.on "keyup", "input.budget", ->
    val = $.trim($(this).val())
    addStorage(cache_key.money, val, false) unless $.isEmptyObject(val)
  .on "change", "select.parent_id", (e) ->
    e.preventDefault()
    val = $.trim($(this).val())
    addStorage(cache_key.category_parent, val, false) unless $.isEmptyObject(val)
  .on "change", "select.category_id", (e) ->
    e.preventDefault()
    val = $.trim($(this).val())
    parent_id = $("select.parent_id", $form).val()
    opts = {} 
    opts[parent_id] = val
    addStorage(cache_key.category, opts, false) unless $.isEmptyObject(val)
  .on "keyup", "input.title", ->
    val = $.trim($(this).val())
    addStorage(cache_key.title, val, false) unless $.isEmptyObject(val)
  .on "keyup", "textarea.description", ->
    val = $.trim($(this).val())
    addStorage(cache_key.category, val, false) unless $.isEmptyObject(val)

  (->
    rows = getStorage(cache_key.atta)
    for row in rows
      addAttaRow(row)

    rows = getStorage(cache_key.compute_type)
    showBudget(rows[0].value, rows[0].text) if rows.length > 0

    rows = getStorage(cache_key.money)
    $("input.budget", $form).val(rows[0]) if rows.length > 0

    rows = getStorage(cache_key.category_parent)    
    if rows.length > 0
      $("select.parent_id", $form).val(rows[0])
      fetchChildren(rows[0])

    rows = getStorage(cache_key.title)
    $("input.title", $form).val(rows[0]) if rows.length > 0

    # rows = getStorage(cache_key.content)
    # $("input.description", $form).val(rows[0]) if rows.length > 0

    validate = () ->
      $elem = $("select.parent_id", $form)
      if $.isEmptyObject($.trim($elem.val()))
        $elem.tooltip(
          msg_type: "danger",
          title: "请选择分类！"
        )
        return false
      $elem = $("select.category_id", $form)
      if $.isEmptyObject($.trim($elem.val()))
        $elem.tooltip(
          msg_type: "danger",
          title: "请选择分类！"
        )
        return false
      $elem = $("input.title", $form)
      if $.isEmptyObject($.trim($elem.val()))
        $elem.tooltip(
          msg_type: "danger",
          title: "请输入标题" 
        )
        return false
      $elem = $("textarea.description", $form)
      if $.isEmptyObject($.trim($elem.val()))
        $elem.tooltip(
          msg_type: 'danger',
          title: "请输入描述" 
        )
        return false

      return true


    $form.on "submit", (e) ->
      return false unless validate()
  )()
