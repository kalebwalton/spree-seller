class AbilityDecorator
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? 'seller'
      can :manage, Product do |product|
        product.try(:seller) == user
      end
      can :manage, Order do |order|
        order.try(:seller) == user
      end
    end
  end
  
end

Ability.register_ability(AbilityDecorator)