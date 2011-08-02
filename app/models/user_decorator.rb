User.class_eval do

  attr_accessible :role

  def role=(role_name)
      @role = role_name
      self.roles << Role.find_by_name(role_name)
  end

  def role
      @role
  end

end
