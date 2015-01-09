class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.merchant?
      can :manage, Ticket, user_id: user.id
    end

    if user && user.admin?
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
    end
  end
end
