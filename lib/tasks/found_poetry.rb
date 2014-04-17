class FoundPoetry
  require 'open-uri'

  def get_poem_serps(number_of_poems)
    number_of_pages = number_of_poems / 20
    total_pages = 576
    @poem_urls = []

    i = 0
    while i < number_of_pages
      page_number = rand(1..total_pages)
      if !PageNumber.where(number: page_number).exists?
        uri = "http://www.poetryfoundation.org/searchresults?page=#{page_number}"
        # sleep(rand(60))
        serp = Nokogiri::HTML(open(uri))
        serp.search("a.title").each do |a| 
          @poem_urls << a.attribute("href").value 
        end
        PageNumber.create(number: page_number)
        i += 1
      end
    end
    @poem_urls.delete_if { |poem_url| poem_url.include?("poetrymagazine") }
    scrape_poems(@poem_urls)
  end

  def scrape_poems(poem_urls)
    poem_urls.each do |poem_url|
      uri = "http://www.poetryfoundation.org#{poem_url}"
      # sleep(rand(60))
      begin
        poem_doc = Nokogiri::HTML(open(uri))
        db_poem = Poem.create(:title => poem_doc.search("#poem-top > h1").text,
                              :first_line => clean_text(poem_doc.search("#poem > .poem").text).first,
                              :content => clean_text(poem_doc.search("#poem > .poem").text).join("\n"),
                              :poet => poem_doc.search("#poemwrapper > .fullname_search").text)
          
        binding.pry
        subjects = extract_categories("subject", poem_doc)
        subjects.each { |name| db_poem.subjects << find_or_create_subject(name.strip) } if !subjects.empty?

        #holidays are occasions at pf
        occasions = extract_categories("occasion", poem_doc)
        occasions.each { |name| db_poem.occasions << find_or_create_occasion(name) } if !occasions.empty?

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

  def clean_text(noko_string)
    noko_string.gsub("\t","").gsub("\r","").split("\n").delete_if(&:empty?)
  end

  def extract_categories(category, poem_noko_doc)
    meta_hash = {}
    poem_noko_doc.search(".about > .section > a").each do |c| 
      if c.attribute("href").value.include?(category)
        meta_hash[c.attribute("href").value] = c.text
      end
    end
    #split lists but not apostrophe's on occasions
    meta_values = meta_hash.values.map { |value| value.split(/&|,/) }.flatten
    categories = meta_values.map { |value| value.strip.downcase }
  end

  def find_or_create_subject(name)
    Subject.find_by_name(name) || Subject.create(name: name)
  end

  def find_or_create_occasion(name)
    Occasion.find_by_name(name) || Occasion.create(name: name)
  end

  class PersistenceError < StandardError
  end

  class LoadError < StandardError
  end

end