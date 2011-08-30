class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(:role => "guest")
    if user.role == "admin"
      can :manage, :all
    elsif user.role == "user"
      can [:index, :show, :add_comment, :new, :create, :over, :finish], Post
      can :manage, Center
      can :all, Comment
    elsif user.role == "guest"
      can [:index, :show], Post
      can :manage, Center
    end
  end
end
