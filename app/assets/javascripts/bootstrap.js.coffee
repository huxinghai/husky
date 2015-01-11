jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

  templates = "<div class='tooltip' role='tooltip'><div class='tooltip-arrow'></div><div class='tooltip-inner'></div></div>"

  oldTp = $.fn.tooltip
  $.fn.tooltip = (opts) ->
    if typeof opts == "object" && opts.hasOwnProperty("msg_type")
      opts.template = $(templates).addClass("tooltip-#{opts.msg_type}")
      oldTp.call(this, opts)
    else
      oldTp.apply(this, arguments)
