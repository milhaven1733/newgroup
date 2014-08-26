module ApplicationHelper

  def render_date datetime
    datetime.to_s(:db)
  end
end
