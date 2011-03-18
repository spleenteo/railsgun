namespace :pages_tree do
  
  desc "Generate pages menu"
  task :generate => :environment do
    @final_console_message = ""
    tree = YAML::load(File.open("#{::Rails.root.to_s}/db/pages_tree.yml"))
    
    # tree is an Hash, lang = key, pages = value
    tree.each do |lang, pages|
      puts "\n"
      puts "Building pages tree for language \'#{lang}\'"
      pages.each_with_index do |page, index|
        create_page(page, lang)       
      end  
      puts "\n"
      puts @final_console_message
      puts "\n"
    end  
  end #end task :generate
  
  
  # Recursively creates pages from a root
  def create_page(page, lang, parent_id=0)
    
    p = Page.new :title => page['title'],
                 :pretty_url => page['pretty_url'],
                 :filename => page['filename'],
                 :lang => lang,
                 :parent_id => parent_id
    # Options
    p.go_to_first_child = page['options']['go_to_first_child'] if page['options'] && page['options']['go_to_first_child']
    p.override_url = page['options']['override_url'] if page['options'] && page['options']['override_url']
    p.meta_title = page['options']['meta_title'] if page['options'] && page['options']['meta_title']
    p.meta_keywords = page['options']['meta_keywords'] if page['options'] && page['options']['meta_keywords']
    p.meta_description = page['options']['meta_description'] if page['options'] && page['options']['meta_description']
    p.layout_name = page['options']['layout_name'] if page['options'] && page['options']['layout_name']
    
    if p.save
      draw_tree(p)
      create_file(p.filename) if !p.filename.blank?
      if !page['children'].blank?
        #Starts recursion
        page['children'].each_with_index do |child, index|
          create_page(child, lang, p.id)
        end   
      end
    else
      puts "========================== Error creating page \'#{p.title}\' =========================="
      p.errors.map {|e| puts e}
    end
  end
  
  def draw_tree(page)
    puts "#{page.ancestors.map{|i| "|   "}}+ #{page.title}"
  end
  
  def create_file(filename, options = {})
    if File.exist?("#{Rails.root}/app/views/pages/_#{filename}.html.erb")
      #puts 'file is there'
    else
      File.new("#{Rails.root}/app/views/pages/_#{filename}.html.erb", "w")
      @final_console_message << "File \'#{Rails.root}/app/views/pages/_#{filename}.html.erb\' created.\n"
    end
  end
  
end
