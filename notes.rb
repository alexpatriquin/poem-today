
KEYWORDS = [
  { :keyword_text => "string"
    :sources => [:twitter, :news],
    :frequency => 500,
    :poems => [
      { :id => 1, :match_type => [:subject, :content] },
      { :id => 5, :match_type => [:title]             },
      { :id => 9, :match_type => [:first_line]        }
    ]
  }
]

UserPoem
user_id | poem_id | match_score | keyword_match_types | keyword_sources    | keyword_frequency | keyword_text
1       | 5       | 80          | [:title]            | [:twitter, :news]  | 500               | "string"

# Store match_type and source as arrays for now...

user_poem = {
  :user_id                => 1,
  :poem_id                => 5,
  :match_score            => 80,
  :keyword_text           => "string",
  :keyword_frequency      => 500,
  :keyword_sources        => [:twitter, :news],
  :keyword_match_types    => [:title]
}





>> KEYWORDS
=> [<Keyword:0x00000104872fd0 
@keyword_text="cloudy", 
@sources=[:forecast], 
@frequency=616, 
@poems=[
  {:id=>1, :match_type=>[:title]}, 
  {:id=>2, :match_type=>[:title]}
  ]
>]


# need to refresh on modules or whatever to eventually get sources and match_type pushing into arrays... 
# too much code right now