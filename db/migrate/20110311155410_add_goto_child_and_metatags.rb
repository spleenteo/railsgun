class AddGotoChildAndMetatags < ActiveRecord::Migration
  def self.up
    add_column :pages, :go_to_first_child, :boolean
    add_column :pages, :meta_title, :string
    add_column :pages, :meta_keywords, :string
    add_column :pages, :meta_description, :string
  end

  def self.down
    remove_column :table_name, :meta_description
    remove_column :pages, :meta_keywords
    remove_column :pages, :meta_title
    remove_column :pages, :go_to_first_child
  end
end
