[:orders, :products, :line_items, :payments, :shipments, :images].each do |name|
  controller = eval("Admin::#{name.to_s.camelize}Controller")
  # This is a hacky way of passing the object_class to the authorize_admin method... couldn't figure out a better way (I'm sure there is)
  controller.class_variable_set("@@object_class", name.to_s.classify.constantize)
  controller.class_eval do
    def authorize_admin
      authorize! :admin, @@object_class
      authorize! params[:action].to_sym, @@object_class
    end
  end
end

Admin::UsersController.class_eval do
  def authorize_admin
    authorize! params[:action].to_sym, User
  end
end

Admin::OverviewController.class_eval do
  def authorize_admin
    authorize! :admin, :overview
  end
end

