module Mine::TicketsHelper
  def title_sort_icon
    if @sort_by == 'title_down' 
      link_to mine_tickets_path(sort_by: :title_up) do
        content_tag(:span, nil, class: 'glyphicon glyphicon-chevron-down')
      end
    else
      link_to mine_tickets_path(sort_by: :title_down) do
        content_tag(:span, nil, class: 'glyphicon glyphicon-chevron-up')
      end
    end 
  end
end
