cal_booking_fee = (quantity) ->
  if quantity > 50 then "10.00" else "5.00"

is_exeed = (quantity, amount) ->
  if quantity > amount then amount else quantity

$ ->
  $('#order_count').change ->
    quantity = $(this).val()
    min_amount = $('#min-amount.amount').text()
    if parseInt(quantity) >= parseInt(min_amount)
      $('#quantity-alert').hide()
      booking_fee = cal_booking_fee(quantity)
      $('#booking-fee').text('$' + booking_fee)
      $('#order_booking_fee').val(booking_fee)
      $('#check-out').attr('disabled', false)
      $.post '/tickets/' + ticket_id + '/calc_price',
        id: ticket_id
        count: $(this).val()
        (data) -> console.log('Calculate Price Success')
    else
      $('#quantity-alert').show()

$ ->
  $('#order_count').keypress (e)->
    if e.keyCode == 13
      $(this).blur()
      return false
