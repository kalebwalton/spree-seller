UserSessionsController.class_eval do
  alias_method :redirect_back_or_default_buyer, :redirect_back_or_default unless method_defined?(:redirect_back_or_default_buyer)

  # Only override the method if it already exists, otherwise we get into a wierd StackOverflow error
  if method_defined?(:redirect_back_or_default)
    def redirect_back_or_default(default)
      if current_user.has_role? 'seller'
        redirect_to(session["user_return_to"] || admin_path)
        session["user_return_to"] = nil
      else 
        redirect_back_or_default_buyer(default)
      end
    end
  end

end
