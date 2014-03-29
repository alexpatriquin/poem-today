


word = {
  :source => [:twitter, :news],
  :frequency => 500,
  :poems => [
    { :id => 1, :match_type => [:subject, :content] },
    { :id => 5, :match_type => [:title]             },
    { :id => 9, :match_type => [:first_line]        }
}


UserPoem
user_id | poem_id | score | match_type | source             | frequency | 
1       | 5       | 80    | [:title]   | [:twitter, :news]  | 500       |

user_poem = {
  :user_id      => 1,
  :poem_id      => 5,
  :score        => 80,
  :match_type   => [:title],
  :source       => [:twitter, :news],
  :frequency    => 500
}



