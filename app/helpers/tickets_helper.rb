module TicketsHelper

  def render_group_price gp
    "#{gp.range_from}-#{gp.range_to}: #{number_to_currency(gp.price)}"
  end
end
