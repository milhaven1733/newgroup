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

get_flat_price = (oprice, discount) ->
  return 0 if discount > 100 or discount < 0
  oprice * (100 - discount) / 100

get_discount = (oprice, flat_price) ->
  return 0 if flat_price.to_i > oprice or flat_price < 0
  100 - flat_price % oprice

$ ->
  $.cookie('group_prices_fields_num', 0)

  if $('#ticket_oprice').val() > 0
    $('#ticket_flatten_discount').removeAttr('disabled')
    $('#ticket_flatten_price').removeAttr('disabled')

  $('#ticket_oprice').keyup ->
    if $(this).val() > 0
      $('#ticket_flatten_discount').removeAttr('disabled')
      $('#ticket_flatten_price').removeAttr('disabled')
    else
      $('#ticket_flatten_discount').attr('disabled', 'disabled')
      $('#ticket_flatten_price').attr('disabled', 'disabled')

  $("#ticket_flatten_discount").keyup ->
    oprice = $("#ticket_oprice").val()
    discount = $(this).val()
    $("#ticket_flatten_price").val(get_flat_price(oprice, discount))

  $("#ticket_flatten_price").keyup ->
    oprice = $("#ticket_oprice").val()
    price = $(this).val()
    
    $("#ticket_flatten_discount").val(get_discount(oprice, price))

  $('#has-student-discount').click ->
    if $(this).is(':checked')
      $('#ticket_student_discount').prop('disabled', false)
    else
      $('#ticket_student_discount').prop('disabled', true)

  $('#free-shipping').click ->
    $('#ticket_shipping').val(0) if $(this).prop('checked')

  # $('#price-tiers').click (event) ->
  #   event.preventDefault()
  #   $('#group-price-tiers').modal('show')

  #   fields_num = $.cookie('group_prices_fields_num')
  #   fields_id = "#ticket_group_prices_attributes_" + fields_num
  #   fields_range_from = fields_id + "_range_from"
  #   fields_range_to = fields_id + "_range_to"

  #   range_max = $("#ticket_amount").val();
  #   range_min = $("#ticket_minimum_amount").val();
  #   if parseInt(range_max) then range_max = parseInt(range_max) else range_max = 100
  #   if parseInt(range_min) then range_min = parseInt(range_min) else range_min = 5
  #   $("#slider").slider("option", {min: range_min, max:range_max})
  #   range = range_min + " - " + range_max
  #   price = $('#ticket_oprice').val()
  #   $('#group-price-tiers-table tbody').append("<tr><td>" + range + "</td><td>$" + price + "</td></tr>")

  $('#group-price-tiers-add').click (event) ->
    event.preventDefault()
    fields_num = $.cookie('group_prices_fields_num')

    fields_id = "#ticket_group_prices_attributes_" + fields_num
    fields_range_from = fields_id + "_range_from"
    fields_range_to = fields_id + "_range_to"
    fields_price = fields_id + "_price"
    range_from = $(fields_range_from).attr("value")
    range_to = $(fields_range_to).attr("value")
    range = range_from + " - " + range_to
    price = $('#group_prices_price').val()
    fields_price = $(fields_price).attr("value")
    $('#group-price-tiers-table tbody').append("<tr><td>" + range + "</td><td>$" + price + "</td></tr>")
    $.cookie('group_prices_fields_num', parseInt(fields_num) + 1)

  $('#ticket_amount').change ->
    $('#ticket_group_prices_attributes_0_range_to').attr("value", $(this).val())

  $('#ticket_minimum_amount').change ->
    $('#ticket_group_prices_attributes_0_range_from').attr("value", $(this).val())

  $('#ticket_oprice').change ->
    $('#ticket_group_prices_attributes_0_price').attr("value", $(this).val())
  $('#ticket_minimum_amount').change ->
    min_amount = $("#ticket_minimum_amount").val()
    if min_amount < 5
      alert("You must enter a quantity of 5 or greater")

