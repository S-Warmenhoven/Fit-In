
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      can :manage, :all
    end
    
    alias_action :create, :read, :update, :destroy, to: :crud

    can :crud, Workout do |workout|
      workout.user == user 
    end

    can :crud, Workout do |workout|
      workout.user == user 
    end
  end
end
