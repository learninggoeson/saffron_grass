class Ability
  include CanCan::Ability

  def initialize(user)
     # Define abilities for the passed in user here.
    user ||= User.new # guest user (not logged in)
    # a signed-in user can do everything
    if user.role == 'admin'
     # an admin can do everything
      can :manage, :all
    elsif user.role == 'customer'
      can :manage, LineItem
      can [:read, :create, :update], Cart
      
      can :read, [Product, About]
      can :create, Contact
      can [:read, :create], Order do |o| o.email = user.email end

    # elsif user.has_role? :guest
    else
      can :manage, LineItem
      # but can only read, create and update charts (ie they cannot
      # be destroyed or have any other actions from the charts_controller.rb
      # executed)
      can [:read, :create, :update], Cart
      # an editor can only view the annual report
      # can :read, [Product, About]
      can :read, Product
      can :create, Contact
      can [:read, :create], Order
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
