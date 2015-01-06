$ ->
  $(".datetimepicker,#datetimepicker").datetimepicker()
  $(".datepicker").datetimepicker({timepicker:false, format:'m/d/Y'})
  $(".timepicker").datetimepicker({datepicker:false, format:'H:i'})

  $(".launch-modal").click ->
    $($(this).data("target")).modal("toggle")

  $(".buy-ticket").submit ->
    count = $("#order_count").val()
    if (count == "" || parseInt(count) < 5)
      confirm("You Must buy at least 5 ticket")
      return false

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

  $('#use-shipping').on "click", (e) ->
    $('#order_billing_address_attributes_first').val($('#order_shipping_address_attributes_first').val())
    $('#order_billing_address_attributes_second').val($('#order_shipping_address_attributes_second').val())
    $('#order_billing_address_attributes_city').val $('#order_shipping_address_attributes_city').val()
    $('#order_billing_address_attributes_state').val $('#order_shipping_address_attributes_state').val()
    $('#order_billing_address_attributes_zipcode').val $('#order_shipping_address_attributes_zipcode').val()
