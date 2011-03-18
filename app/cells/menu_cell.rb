class MenuCell < Cell::Rails
  # Can't get helper methods generated from Application Controller's methods
  helper :application
  
  def first_level(args)
    @page = args[:page]
    lang = args[:lang] ? args[:lang] : @page.lang
    @first_level_pages = Page.where(:parent_id => 0, :lang => lang)
    fill_menu_variables(@page)
    @remote = !args[:remote].blank?
    render
  end
  
  def two_levels(args)
    @page = args[:page]
    lang = args[:lang] ? args[:lang] : @page.lang
    @first_level_pages = Page.where(:parent_id => 0, :lang => lang)
    fill_menu_variables(@page)
    @remote = !args[:remote].blank?
    render
  end
  
  def siblings(args)
    @page = args[:page]
    fill_menu_variables(@page)
    @remote = !args[:remote].blank?
    render
  end
  
  def children(args)
    @page = args[:page]
    fill_menu_variables(@page)
    @remote = !args[:remote].blank?
    render
  end
  
  def siblings_and_children(args)
    @page = args[:page]
    fill_menu_variables(@page)
    @remote = !args[:remote].blank?
    render
  end
  
  def footer(args)
    @page = args[:page]
    lang = args[:lang] ? args[:lang] : @page.lang
    @first_level_pages = Page.where(:parent_id => 0, :lang => lang)
    fill_menu_variables(@page)
    @remote = !args[:remote].blank?
    render
  end
  
  private
  
  def fill_menu_variables(page)
    @current_level_pages = Page.where(:parent_id => page.parent_id)
    @family_pages_ids = [page.id] #parents and sons, no siblings
    @family_pages_ids << page.ancestors.map{|a| a.id}
    @family_pages_ids = @family_pages_ids.compact.flatten
  end
  
end
