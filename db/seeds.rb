# walk = Poem.create(poet: "Robert Frost")
# walk.title = "Code Day"
# walk.first_line = "Alex"

# day = Subject.create(name: "birth")
# night = Occasion.create(name: "birthday")

# walk.subjects << day
# walk.occasions << night
# walk.save

# alex = User.create(email: "alexpatrquin@gmail.com", password: "abc123", password_confirmation: "abc123")
# alex.first_name = "Alex"
# alex.birthday = ""
# alex.location = "10009"
# alex.save

class PoemScraper
require 'open-uri'

  def get_poem_serps
    number_of_poems = 100
    number_of_pages = number_of_poems / 20
    total_pages = 576
    @poem_urls = []

    number_of_pages.times do 
      uri = "http://www.poetryfoundation.org/searchresults?page=#{rand(total_pages)}"
      serp = Nokogiri::HTML(open(uri))
      serp.search("a.title").each { |a| @poem_urls << a.attribute("href").value }
    end
  end

  def scrape_poems
    @poem_urls.each do |poem_url|
      uri = "http://www.poetryfoundation.org#{poem_url}"
      poem_doc = Nokogiri::HTML(open(uri))
      db_poem = Poem.create(:title => poem_doc.search("#poem-top > h1").text,
                            :first_line => clean_text(poem_doc.search("#poem > .poem").text).first, 
                            :content => clean_text(poem_doc.search("#poem > .poem").text).join("\n"), 
                            :poet => poem_doc.search("#poemwrapper > .fullname_search").text)
      
      rescue
        puts "Could not create #{title}"
        next
      end
      if !db_poem.persisted?
        puts "Could not persist #{poem_url}"
        next
      else
        puts "Created poem #{poem_url}"
      end
    end
  end

  class PersistenceError < StandardError
  end

  class LoadError < StandardError
  end

  def clean_text(noko_string)
    noko_string.gsub("\t","").gsub("\r","").split("\n").delete_if(&:empty?)
  end

  def create_subject
  end

  def create_occasion
  end

end
