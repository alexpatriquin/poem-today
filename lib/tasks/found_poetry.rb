class FoundPoetry

  def self.get_poems
    # response = GoogleBooks.search(title, :api_key => "AIzaSyCvOuvO_hQS_ZULj8Q4vIBttWefh6kv8zY")
    # return raise LoadError if !response

    response.to_a.each_with_index do |poem|

      begin
        db_poem = Poem.create(:title =>
                              :first_line =>
                              :content =>
                              :poet =>
                              :isbn => 
                              )

        # :subjects::name
        # :occasions::name

      rescue
        puts "Could not create #{title}"
        next
      end

      if !db_book.persisted?
        puts "Could not persist #{title}"
        next
      else
        puts "Created book #{poem.id}, #{poem.title}"
      end

    end

  end

  class PersistenceError < StandardError
  end

  class LoadError < StandardError
  end

end