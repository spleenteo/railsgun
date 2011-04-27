module ApplicationHelper
  
  ##############################################################################################
  # Some code is duplicated from Application Controller due to an issue of Cells with Rails 3  #
  # Cells can't access helper methods generated from Application Controller                    #
  ##############################################################################################
  
  
    # Generates destination for pages menu snippets
    def page_link_destination(p)
      if p.override_url
        link_destination = p.override_url
      elsif (p.go_to_first_child && !p.children.blank? && p.children.first)
        link_destination = get_railsgun_url(p.children.first.pretty_url)
      else
        link_destination = get_railsgun_url(p.pretty_url)
      end
      link_destination
    end
  
    # Gets language from requested url if available,
    # otherwise uses the browser's user agent if included in available languages,
    # lastly uses the default language.
    def get_lang
      req = request.fullpath
      curr_lang = req.split('/').first
      if !curr_lang.blank? && curr_lang.length == 2 && curr_lang =~ $AVAILABLE_LANGUAGES
        lang = curr_lang
      else
        lang_tmp = $DEFAULT_LANGUAGE
        lang_tmp = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first unless (request.env.nil? || request.env['HTTP_ACCEPT_LANGUAGE'].blank?)
        lang = ((lang_tmp && lang_tmp =~ $AVAILABLE_LANGUAGES) ? lang_tmp : $DEFAULT_LANGUAGE)
      end
      lang
    end
    
    # Returns the first page of the language tree
    def railsgun_home
      Page.find(:first, :order => "position ASC", :conditions => ["lang = ?", get_lang])
    end
    
    # Calculates the full pretty url for a given page
    def get_railsgun_url(dest, options = {})  
      lang = options[:lang].blank? ? get_lang : options[:lang]   
      if dest.kind_of? String
        page = Page.find(:first, :conditions => ["pretty_url = ?", dest]) #find by Page's pretty url
      elsif dest.kind_of? Integer
        page = Page.find(dest) #find by Page's id
      elsif dest.class == Page
        page = Page.find(dest.id)
      end
      
      if page && lang =~ $AVAILABLE_LANGUAGES
        railsgun_url = "/#{lang}" 
        page.ancestors.reverse.each{|a| railsgun_url << "/#{a.pretty_url}"}
        railsgun_url << "/#{page.pretty_url}"
      else
        "/"
      end  
    end
  
end
