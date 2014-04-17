namespace :fp do

  task :fp_env do
    ENV["RAILS_ENV"] ||= 'development'
    require File.expand_path("../../../config/environment", __FILE__)
    Bundler.require(:default)
  end

  desc "Seed the database with found poetry"
  task :seed_poems => [:fp_env] do
    require_relative "found_poetry.rb"
        
      begin
        poems = FoundPoetry.new.get_poem_serps(20)
      rescue LoadError
        puts "Couldn't get poems"
        next
      end
      puts "Persisted poems"
  end
end
