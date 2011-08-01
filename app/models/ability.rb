class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role == "admin"
      can :manage, Admin
    elsif user.role == "guest"
      cannot [:show,:index], Post
    end
  end
end
