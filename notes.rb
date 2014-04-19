./ngrok 3000






# FOR EACH :keyword_source...
keyword = [
  { :keyword_text => "string",
    :keyword_frequency => 500,
    :keyword_source => :twitter,
    :poems => [
      { :id => 5, :match_type => :title,     }, #each of these gets its own match_score
      { :id => 9, :match_type => :first_line }, #match_type can also be random, birthday, occasion, etc.
      { :id => 1, :match_type => :subject    }
    ]
  }
]

#ONLY KEEP THE WINNER...
UserPoem
user_id | poem_id | match_score | keyword_match_type | keyword_source | keyword_frequency | keyword_text
1       | 5       | 80          | :title             | :twitter       | 50                | "string"



# @keywords get looked up > @matches get made > @results get scored

[1] pry(#<ForecastPoem>)> @keywords
=> [#<Keyword:0x00000102fc18b0
  @frequency=616,
  @poems=[{:id=>3, :match_type=>:title}, {:id=>1, :match_type=>:content}],
  @source=:forecast,
  @text="heavy">,
 #<Keyword:0x00000106f0b2a0
  @frequency=442,
  @poems=[{:id=>1, :match_type=>:title}, {:id=>3, :match_type=>:title}],
  @source=:forecast,
  @text="rain">,
 #<Keyword:0x0000010a003448
  @frequency=785,
  @poems=[],
  @source=:forecast,
  @text="starting">,
 #<Keyword:0x000001048639e0
  @frequency=695,
  @poems=[],
  @source=:forecast,
  @text="afternoon">]

[2] pry(#<ForecastPoem>)> @matches
=> [{:poem_id=>3,
  :match_type=>:title,
  :keyword_text=>"heavy",
  :keyword_frequency=>616,
  :keyword_source=>:forecast},
 {:poem_id=>1,
  :match_type=>:content,
  :keyword_text=>"heavy",
  :keyword_frequency=>616,
  :keyword_source=>:forecast},
 {:poem_id=>1,
  :match_type=>:title,
  :keyword_text=>"rain",
  :keyword_frequency=>442,
  :keyword_source=>:forecast},
 {:poem_id=>3,
  :match_type=>:title,
  :keyword_text=>"rain",
  :keyword_frequency=>442,
  :keyword_source=>:forecast}]

[3] pry(#<PoemMatcher>)> @results
=> [{:poem_id=>1,
  :match_type=>:content,
  :keyword_text=>"heavy",
  :keyword_frequency=>616,
  :keyword_source=>:forecast,
  :match_score=>68},
 {:poem_id=>3,
  :match_type=>:title,
  :keyword_text=>"rain",
  :keyword_frequency=>442,
  :keyword_source=>:forecast,
  :match_score=>125}]