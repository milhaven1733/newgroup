class GroupsController < ApplicationController
  before_action :set_ticket
  before_action :set_group, only: [:join_pay]

  def new
    @group = @ticket.groups.new
  end

  def create
    @group = @ticket.groups.new group_params.merge(leader: current_user)
    if @group.save
      redirect_to @ticket, notice: 'Create group for ticket success'
    else
      render action: :new, error: 'Create group for ticket fail'
    end
  end

  def join_pay
    @group_user = @group.groups_users.new group_user_params.merge(user: current_user, status: :paid)
    @group_user.save
  end

  private

  def set_ticket
    @ticket = Ticket.find params[:ticket_id]
  end

  def set_group
    @group = @ticket.groups.find params[:id]
  end

  def group_params
    params.require(:et_group).permit(:name, :deadline, :target_amount)
  end

  def group_user_params
    params.require(:groups_user).permit(:amount)
  end
end
