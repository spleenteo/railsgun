class PagesController < ApplicationController
  layout :set_layout
  respond_to :html, :js, :only => :show
  
  # Page cache disabled - unsupported on Heroku
  #caches_page :show
  
  # def index
  #   respond_with(@pages = Page.all)
  # end
  
  def show
    if params[:page_url].blank? && params[:locale].blank?
      redirect_to get_railsgun_url(railsgun_home)
    elsif params[:page_url].blank? && !params[:locale].blank?
      redirect_to get_railsgun_url(railsgun_home, {:lang => params[:locale]})
    else
      page_url = params[:page_url]
      splitted_page_url = page_url.split('/')
      @page = Page.find(:first, :conditions => ["pretty_url = ?", splitted_page_url.last]) unless page_url.last.nil?
      if @page
        respond_with(@page, @pages = Page.all, @lang=params[:locale])     
      end     
    end
  end # show
  
  
  private
  
  def set_layout
    @page && @page.layout_name ? @page.layout_name : "application"
  end
  
end
