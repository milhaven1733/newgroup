class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user.present? ? user : User.new
    @user.new_record? ? guest_rules : user_rules
  end

  def user_rules
    if @user.merchant? || @user.admin?
      send("#{@user.role}_rules")
    else
      normal_rules
    end
  end

  def normal_rules
    can :manage, :mine
    # for order
    can [:new, :create], Order
    can [:index, :update, :show], Order do |order|
      order.user_id == @user.id
    end
    # for profile
    can [:user, :like], :profile
    # for ticket
    can [:show, :like, :calc_price], Ticket
    # for wallet
    can [:show, :recharge, :withdraw], :wallet
  end

  def merchant_rules
    can :manage, :mine
    can [:show, :calc_price], Ticket
    can :manage, Ticket, user_id: @user.id
    # for order
    can [:index, :update, :show], Order do |order|
      order.try(:ticket).try(:user_id) == @user.id
    end
    # for profile
    can [:merchant], :profile
    # for ticket
    can [:new, :create], Ticket
    can [:index, :show, :edit, :update, :destroy], Ticket do |ticket|
      ticket.user_id == @user.id
    end
    # for wallet
    can [:show, :recharge, :withdraw], :wallet
    # for group price
    can [:new, :create], GroupPrice
    can :destroy, GroupPrice do |gprice|
      gprice.ticket.try(:user_id) == @user.id
    end
  end

  def admin_rules
    can :access, :rails_admin
    can :dashboard
    can :manage, :all
  end

  def guest_rules
    can [:show, :calc_price], Ticket
    can [:merchant], :profile
  end
end
