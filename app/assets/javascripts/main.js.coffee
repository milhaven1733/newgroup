$ ->
  $(".datetimepicker").datetimepicker()

  $(".launch-modal").click ->
    $($(this).data("target")).modal("toggle")

  $("#recharge").change ->
    $("#recharge-stripe-button").data("amount", parseInt(parseFloat($(this).val()) * 100)||0)
