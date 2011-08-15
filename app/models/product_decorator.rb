Product.class_eval do

  belongs_to :seller, :foreign_key => :seller_id, :class_name => "User"
  
  validates :seller_id, :presence => true

end
