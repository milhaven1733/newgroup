class Ability
  include CanCan::Ability

  #def initialize(user)
  #  user ||= User.new

  #  if user.merchant?
  #    can :manage, Ticket, user_id: user.id
  #  end

  #  if user.admin?
  #    can :access, :rails_admin
  #    can :dashboard
  #    can :manage, :all
  #  end
  #end

  def initialize(user)
    @user ||= User.new
    @user.new_record? ? guest_rules : user_rules
  end

  def user_rules
    if @user.merchant? or @user.admin?
      send("#{@user.role}_rules")
    else
      normal_rules
    end
  end

  def normal_rules
  end

  def merchant_rules
    can :manage, Mine::Ticket, user_id: user.id
  end

  def admin_rules
    can :access, :rails_admin
    can :dashboard
    can :manage, :all
  end

  def guest_rules
  end
end
