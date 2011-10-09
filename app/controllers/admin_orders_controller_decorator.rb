Admin::OrdersController.class_eval do
  alias_method :index_admin, :index unless method_defined?(:index_admin)
  
  def index
    # Scope orders down to the currently logged in seller
    if User.current.has_role? 'seller'
      params[:search] ||= {}
      params[:search][:seller_id_equals] = User.current.id
    end
    index_admin
  end

end
