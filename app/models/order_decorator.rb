Order.class_eval do

  belongs_to :seller, :foreign_key => :seller_id, :class_name => "User"
  
  validate :contains_products_from_only_one_seller

  before_create :associate_with_seller
  
  def associate_with_seller
    # Associate this order with the seller associated with the first product
    self.seller_id = products[0].seller_id unless products.nil? or products.empty?
  end
  
  private
   
    def contains_products_from_only_one_seller
      sellers = products.collect{|product| product.seller_id}.uniq
      self.errors[:base] << I18n.t('order_must_not_contain_products_from_multiple_sellers') if sellers.length > 1
    end

end
