class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.merchant?
      can :manage, Ticket, user_id: user.id
    end
  end
end
