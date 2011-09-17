OrdersController.class_eval do
  alias_method :populate_without_single_seller_check, :populate

  def populate
    @order = current_order(true)
    
    # Enumerate the products/variants in the current order and make sure there will be only one seller after adding 
    # the requested products/variants. Also make sure there will only be one of each product as we don't do stock.
    products = @order.products
    seller_ids = []
    seller_ids.concat(products.collect{|product| product.seller_id}) unless products.nil? or products.empty?
    product_ids = []
    product_ids.concat(products.collect{|product| product.id}) unless products.nil? or products.empty?
    
    params[:products].each do |product_id,variant_id|
      seller_ids << Variant.find(variant_id).product.seller_id
      product_ids << Variant.find(variant_id).product.id
    end if params[:products]

    params[:variants].each do |variant_id, quantity|
      seller_ids << Variant.find(variant_id).product.seller_id
      product_ids << Variant.find(variant_id).product.id
    end if params[:variants]
    
    #TODO this is not a requirement of the seller extension... need to factor this constraint out
    if product_ids.uniq.length < product_ids.length
      flash[:error] = I18n.t('order_must_not_contain_the_same_product_twice')
      respond_with(@order) { |format| format.html { redirect_to cart_path } }
    elsif seller_ids.uniq.length > 1
      flash[:error] = I18n.t('order_must_not_contain_products_from_multiple_sellers')
      respond_with(@order) { |format| format.html { redirect_to cart_path } }
    else
      populate_without_single_seller_check
    end
  end
  
end