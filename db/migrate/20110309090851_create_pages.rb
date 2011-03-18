class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.column :parent_id, :integer
      t.column :position, :integer
      t.column :title, :string
      t.column :pretty_url, :string
      t.column :filename, :string
      t.column :lang, :string
      t.timestamps
    end
    #Page.create_translation_table! :title => :string, :pretty_url => :string
  end

  def self.down
    drop_table :pages
    #Page.drop_translation_table!
  end
end
