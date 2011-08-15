Admin::NavigationHelper.class_eval do

  # Make an admin tab that coveres one or more resources supplied by symbols
  # Option hash may follow. Valid options are
  #   * :label to override link text, otherwise based on the first resource name (translated)
  #   * :route to override automatically determining the default route
  #   * :match_path as an alternative way to control when the tab is active, /products would match /admin/products, /admin/products/5/variants etc.
  def custom_tab(*args)
    # Only show the Orders and Products tabs to Sellers
    original_tab(*args) unless User.current.has_role? 'seller' and [:overview, :reports, :configurations, :users].include?(args[0])
  end

  # Important to alias these methods AFTER custom_tab is defined
  alias_method :original_tab, :tab
  alias_method :tab, :custom_tab

end

