Admin::OrdersController.class_eval do
  alias_method :index_admin, :index unless method_defined?(:index_admin)
  alias_method :check_authorization_admin, :check_authorization unless method_defined?(:check_authorization_admin)
  
  def index
    # Scope orders down to the currently logged in seller
    if !User.current.nil? and User.current.has_role? 'seller'
      params[:search] ||= {}
      params[:search][:seller_id_equals] = User.current.id
    end
    index_admin
  end

  # FIXME We had to remove the session[:access_token] from the authorize! method in order for this to work
  def check_authorization
    load_order
    session[:access_token] ||= params[:token]

    resource = @order || Order
    action = params[:action].to_sym
    authorize! action, resource
  end

end
