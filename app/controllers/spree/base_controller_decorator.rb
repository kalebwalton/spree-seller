Spree::BaseController.class_eval do
  
  # Prints authorization exceptions to stdout so we can see them
  rescue_from CanCan::AccessDenied do |exception|
    return unauthorized
  end
end
