namespace :fp do

  task :fp_env do
    ENV["RAILS_ENV"] ||= 'development'
    require File.expand_path("../../../config/environment", __FILE__)
    Bundler.require(:default)
  end

  desc "Seed the database with found poetry"
  task :seed_poems => [:fp_env] do
    require_relative "found_poetry.rb"

    @titles_array.flatten.each do |title|
      begin
        FoundPoetry.get_books(title)
      rescue LoadError
        puts "Couldn't load books by title #{title}"
        next
      end

      puts "Persisted book records for title #{title}"

    end

  end

end
