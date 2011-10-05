Admin::NavigationHelper.class_eval do

  def custom_tab(*args)
    # Return nothing if the user can't access this area
    authable = args.first.to_s.classify.constantize rescue args.first
    
    return "" unless can? :admin, authable
    
    # Scrub inaccessible items from the secondary navigation
    args.reject! {|arg| 
      !arg.is_a?(Hash) && !can?(:admin, arg.to_s.classify.constantize) rescue false
    }
    
    original_tab(*args)
  end

  # Important to alias these methods AFTER custom_tab is defined
  alias_method :original_tab, :tab
  alias_method :tab, :custom_tab

end

