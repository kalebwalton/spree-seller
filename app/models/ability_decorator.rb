class AbilityDecorator
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role? 'seller'
    
      {
        Product => :direct,
        ProductProperty => :product,
        Order => :direct,
        LineItem => :order,
        Variant => :product,
        Payment => :order,
        Shipment => :order,
        ProductOptionType => :product,
        Image => :product
      }.each_pair do |klass, path|
        can :admin, klass
        can :manage, klass do |obj|
          next true if obj.nil? or (obj.is_a? ActiveRecord::Base and obj.new_record?)
          if obj.is_a? Array
            obj.index{|o| resolve_seller_through(path, o) == user}.nil?
          else
            resolve_seller_through(path, obj) == user
          end
        end
      end

      can :index, User
      can :read, User
      
      can :index, OptionType
      can :read, OptionType
      
      can :available, Prototype
      can :select, Prototype
      can :read, Prototype
      
      can :selected, Taxon
      can :select, Taxon
      can :available, Taxon
      can :read, Taxon
      
      can :admin, :overview
    end
  end
  
  def resolve_seller_through(path, object) 
    if (!object.nil?) 
      if (path == :direct) 
        object.try(:seller) if object.respond_to? :seller
      else
        resolve_seller_through(:direct, object.try(path))
      end
    end
  end
  
  
end

Ability.register_ability(AbilityDecorator)