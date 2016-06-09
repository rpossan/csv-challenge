namespace :csvloader do
  require 'csv'
  desc "Load csv to database from specific path"
  task load: :environment do
  	loader = ProfileLoader.new('us-500.csv')
  	loader.load
  end

  desc "Purge all records from database from Profile, City and State"
  task purge: :environment do
  	ProfileLoader.purge
  end

  desc "TODO"
  task retry: :environment do
  end

end
