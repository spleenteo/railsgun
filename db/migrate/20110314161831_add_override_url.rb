class AddOverrideUrl < ActiveRecord::Migration
  def self.up
    add_column :pages, :override_url, :string
  end

  def self.down
    remove_column :pages, :override_url
  end
end
