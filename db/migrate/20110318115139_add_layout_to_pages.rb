class AddLayoutToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :layout_name, :string
  end

  def self.down
    remove_column :pages, :layout_name
  end
end
