class Page < ActiveRecord::Base
  
  acts_as_tree :order => "position"
  #acts_as_list :scope => :parent_id
  acts_as_list
  
  # Scope conditions for acts_as_list
  # Scopes both for parent_id and position
  def scope_condition
    "parent_id = #{parent_id.to_i} AND #{connection.quote_column_name("lang")} = #{quote_value(lang)}" 
    # Equals to:  "parent_id = #{parent_id.to_i} AND \'lang\' = \'#{lang}\'" 
  end
    
  # Callbacks
  before_validation :check_pretty_url
  
  # Validations
  validates :title,
            :presence => true,
            :uniqueness => true
  validates :pretty_url,
            :presence => {:unless => Proc.new {|page| (page.go_to_first_child || page.override_url)}},
            :uniqueness => true
  validates :lang,
            :presence => true,
            :length => { :is => 2 }
  validates :filename,
            :presence => {:unless => Proc.new {|page| (page.go_to_first_child || page.override_url)}},
            :uniqueness => true
  

  private
  
  def check_pretty_url
    self.pretty_url = (self.pretty_url.blank? || self.pretty_url.urlify.blank?) ? self.title.urlify : self.pretty_url.urlify
  end
  
end
