namespace :csvloader do
  require 'csv'
  desc "Load csv to database from specific path"
  task load: :environment do
  	loader = ProfileLoader.new('us-500.csv')
  	loader.load
  end

  desc "TODO"
  task purge: :environment do
  end

  desc "TODO"
  task retry: :environment do
  end

end
