Admin::OrdersController.class_eval do
  alias_method :index_admin, :index

  def authorize_admin
    authorize! :admin, Order
    authorize! params[:action].to_sym, Order
  end
  
  def index
    # Scope orders down to the currently logged in seller
    if User.current.has_role? 'seller'
      params[:search] ||= {}
      params[:search][:seller_id_equals] = User.current.id
    end
    index_admin
  end

end

Admin::ProductsController.class_eval do
  alias_method :collection_admin, :collection

  def authorize_admin
    authorize! :admin, Product
    authorize! params[:action].to_sym, Product
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

Admin::LineItemsController.class_eval do
  def authorize_admin
    authorize! :admin, LineItem
    authorize! params[:action].to_sym, LineItem
  end
end

Admin::UsersController.class_eval do
  def authorize_admin
    authorize! params[:action].to_sym, User
  end
end

