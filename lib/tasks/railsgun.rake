namespace :railsgun do
  
  desc "Drop, recreate, migrate and populate pages tree from yaml"
  task :init do  
    Rake::Task['db:reset'].invoke
    Rake::Task['pages_tree:generate'].invoke
    Rake::Task['assets:deploy'].invoke
  end
  
end
