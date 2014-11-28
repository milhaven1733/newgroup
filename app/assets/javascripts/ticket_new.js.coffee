to_percentage = (num) ->
  if num > 0 and num < 1
    (num * 100) + '%'
  else
    num

from_percentage = (str) ->
  if str.charAt(str.length-1) is '%'
    num = str.substring(0,str.length-1)
    if isNaN(num)
      null
    else
      num / 100.0
  else
    str

$ ->
  if $('#ticket_oprice').val() > 0
    $('#ticket_flat_discount').removeAttr('disabled')
    $('#ticket_flat_price').removeAttr('disabled')

  $('#ticket_oprice').keyup ->
    if $('#ticket_oprice').val() > 0
      $('#ticket_flat_discount').removeAttr('disabled')
      $('#ticket_flat_price').removeAttr('disabled')
    else
      $('#ticket_flat_discount').attr('disabled', 'disabled')
      $('#ticket_flat_price').attr('disabled', 'disabled')

  $("#ticket_flat_discount").keyup ->
    oprice = $("#ticket_oprice").val()
    discount = $(this).val()
    $("#ticket_flat_price").val oprice * (100 - discount) / 100

  $("#ticket_flat_price").keyup ->
    oprice = $("#ticket_oprice").val()
    price = $(this).val()
    $("#ticket_flat_discount").val (1 - price / oprice).toFixed(2) * 100

  $('#has-student-discount').click ->
    if $(this).is(':checked')
      $('#ticket_student_discount').prop('disabled', false)
    else
      $('#ticket_student_discount').prop('disabled', true)

  $('#free-shipping').click ->
    $('#ticket_shipping').val(0) if $(this).prop('checked')