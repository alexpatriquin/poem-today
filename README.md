
# [![](/app/assets/images/logo_small.png "PoemToday logo")](http://poemtoday.com/) PoemToday
PoemToday is a simple Rails app and algorithm that matches users to poems based on profile info and enables them to create interesting Markov chains by browsing poems.

*Poem Page (with top Flickr photo for referral keyword)*

![](/public/assets/stats_poem.png "Poem Page")

## Random Poem Generator
Each of the 6,000 poems currently on PoemToday actually has a link wrapped around every word in every poem. When a user clicks one of the words, the site initiates a search of its database for the best-matching poem and redirects the user to the top result, alongside with the top image from the Flickr API for that word.

Behind the scenes, PoemToday is storing information about all of the words the user has clicked and the poems the user has visited in a temporary session. When the session has enough data, it statistically generates a completely unique "ephemeral" poem with a statistical process known as a Markov chain.

Markov chains, of course, are a remarkably simple mathematical operation capable of producing uncanny results when modeling human-written texts. In the spirit of the memorylessness of Markov Chains, randomly-generated poems on PoemToday aren't stored. When the user leaves or reloads poemtoday.com/ephemeral, the session is cleared and your Markov poem is gone.

## Daily Email Algorithm
PoemToday also features a daily email option. The app will email the user a poem every morning, along with information about why that poem was matched to the user on that day. The daily email matching is based on whatever inputs the user shares with PoemToday. Currently available inputs are first name, birthday, location and Twitter handle. So, for example, if the user tells PoemToday her location, it will look up her weather forecast and match words in her location's forecast summary with poems in its database.

Special occasions, like holidays, and New York Times' Most Emailed articles for that day also serve as special inputs for all users. The scoring section of the algorithm at [app/models/poem_scorer](app/models/poem_scorer.rb) provides a nice overview on how it all works.

When matching users' keyword sources with poems every morning, PoemToday takes into account where in the poem the keywords were found, as well as the frequency of the word's occurence in English language usage, which is provided via the Wordnik API. Extremely high frequency words, such as articles and prepositions, are automatically removed with a high cut-off score. 

Frequency is like a golf score, the lower the better. Thus more points are assigned to rare words by subtracting all keyword frequencies from 1000. When applicable, the word "birthday", first names and holiday names are treated as keywords and given a score of 0, so they automatically trump other keyword and sources.

Daily Email matches are saved on the user's homepage, with details about the match, including links to original keyword source where applicable (eg, with Tweets or New York Times articles).

## Continuing Development
Continuing development plans include additional user feedback mechanisms for the matching algorithms and a/b testing a Natural Language Generation (such as simplenlg) realization engine against the Markov Chain.

## Screenshots
*Homepage (Signed in)*

![](/public/assets/homepage_signed_in.png "Homepage (signed in)")

*Markov Poem Page*

![](/public/assets/markov_storage.png "Markov Poem Page")

## Domain Model
![](/public/assets/erd.png "Database Schema")

## Built With
- [Ruby on Rails](https://github.com/rails/rails) &mdash; PoemToday
 is a Rails app using RESTful routes and MVC architecture.
- [PostgreSQL](http://www.postgresql.org/) &mdash; The database is Postgres.
- [RubyGems](https://github.com/AlexPatriquin/BitcoinMessenger/blob/master/Gemfile) &mdash; A full list of gems can be found in the Gemfile.

## License
[MIT License](/mit-license). Copyright 2014 Alex Patriquin.


