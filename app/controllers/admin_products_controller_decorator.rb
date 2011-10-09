Admin::ProductsController.class_eval do
  alias_method :collection_admin, :collection unless method_defined?(:collection_admin)
  create.before :set_seller
  
  def set_seller
    @object.seller = User.current unless @object.nil?
  end

  def collection
    # Scope products down to the currently logged in seller
    if current_user.has_role? 'seller'
      params[:search] ||= {}
      params[:search][:seller_id_equals] = current_user[:id]
    end
    collection_admin
  end
end
