Admin::BaseController.class_eval do
  before_filter :authorize_admin

  def authorize_admin
    authorize! :admin, Object unless !User.current.nil? && (User.current.has_role?('admin') or User.current.has_role?('seller'))
  end
end