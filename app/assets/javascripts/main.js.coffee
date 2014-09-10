$ ->
  $(".datetimepicker").datetimepicker()

  $('#favourite').on "click",  (e) ->
    e.preventDefault()
    that = this
    $.ajax({
      url: $(this).attr("href"),
      data: {voted: $(this).data("voted")},
      type: "POST",
      success: ->
        if $(that).data("voted") == true
          $(that).children('span').removeClass("glyphicon-heart").addClass("glyphicon-heart-empty").fadeIn("slow")
          $(that).data("voted", false)
        else
          $(that).children('span').removeClass("glyphicon-heart-empty").addClass("glyphicon-heart").fadeIn("slow")
          $(that).data("voted", true)
    })
    return false
