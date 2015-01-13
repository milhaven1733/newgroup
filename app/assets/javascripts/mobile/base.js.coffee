$ ->
  $('#use-shipping').on "click", (e) ->
    if this.checked
      $('#order_billing_address_attributes_first').val($('#order_shipping_address_attributes_first').val())
      $('#order_billing_address_attributes_second').val($('#order_shipping_address_attributes_second').val())
      $('#order_billing_address_attributes_city').val $('#order_shipping_address_attributes_city').val()
      $('#order_billing_address_attributes_state').val $('#order_shipping_address_attributes_state').val()
      $('#order_billing_address_attributes_zipcode').val $('#order_shipping_address_attributes_zipcode').val()
    else
      $('#order_billing_address_attributes_first').val ''
      $('#order_billing_address_attributes_second').val ''
      $('#order_billing_address_attributes_city').val ''
      $('#order_billing_address_attributes_state').val ''
      $('#order_billing_address_attributes_zipcode').val '' 
