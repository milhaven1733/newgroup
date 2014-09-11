module ApplicationHelper
  def render_date(datetime)
    datetime.to_s(:db)
  end

  def liked?(ticket)
    current_user.present? && !current_user.votes.where(votable_id: ticket.id).blank?
  end
end
