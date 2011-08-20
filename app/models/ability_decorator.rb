class AbilityDecorator
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? 'seller'
      can :admin, Product
      can :manage, Product do |obj|
        if obj.is_a? Array
          obj.index{|o| o.try(:seller) == user}.nil?
        else
          obj.try(:seller) == user
        end
      end

      can :admin, Order
      can :manage, Order do |obj|
        if obj.is_a? Array
          obj.index{|o| o.try(:seller) == user}.nil?
        else
          obj.try(:seller) == user
        end
      end

      can :admin, LineItem
      can :manage, LineItem do |obj|
        if obj.is_a? Array
          obj.index{|o| o.try(:order).try(:seller) == user}.nil?
        else
          obj.try(:order).try(:seller) == user
        end
      end

      can :admin, Variant
      can :manage, Variant do |obj|
        if obj.is_a? Array
          obj.index{|o| o.try(:product).try(:seller) == user}.nil?
        else
          obj.try(:product).try(:seller) == user
        end
      end

      can :index, User
      can :read, User
    end
  end
  
end

Ability.register_ability(AbilityDecorator)