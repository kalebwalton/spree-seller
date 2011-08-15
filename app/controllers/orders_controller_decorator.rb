OrdersController.class_eval do
  alias_method :populate_without_single_seller_check, :populate

  def populate
    @order = current_order(true)
    
    # Enumerate the products/variants in the current order and make sure there will be only one seller after adding 
    # the requested products/variants
    # There shouldn't be more than one seller yet, so we're not checking for it
    products = @order.products
    seller_ids = products.collect{|product| product.seller_id} unless products.nil? or products.empty?
    
    params[:products].each do |product_id,variant_id|
      seller_ids << Variant.find(variant_id).product.seller_id
    end if params[:products]

    params[:variants].each do |variant_id, quantity|
      seller_ids << Variant.find(variant_id).product.seller_id
    end if params[:variants]
    
    if seller_ids.uniq.length > 1
      flash[:error] = I18n.t('order_must_not_contain_products_from_multiple_sellers')
    else
      populate_without_single_seller_check
    end
  end
  
end