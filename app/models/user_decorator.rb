User.class_eval do

  has_many :products, :foreign_key => :seller_id
  has_many :orders, :foreign_key => :seller_id

  scope :seller, lambda { includes(:roles).where("roles.name" => "seller") }
  scope :buyer, lambda { includes(:roles).where("roles.name" => "buyer") }

  attr_accessible :role

  def role=(role_name)
      @role = role_name
      self.roles << Role.find_by_name(role_name)
  end

  def role
      @role
  end

end
