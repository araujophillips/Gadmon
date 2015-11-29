jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

(($) ->
  $('.spinner .btn:first-of-type').on 'click', ->
    $('.spinner input').val parseInt($('.spinner input').val(), 10) + 1
    return
  $('.spinner .btn:last-of-type').on 'click', ->
    $('.spinner input').val parseInt($('.spinner input').val(), 10) - 1
    return
  return
) jQuery