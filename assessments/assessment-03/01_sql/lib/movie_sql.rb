require 'singleton'
require 'sqlite3'

class MovieDatabase < SQLite3::Database
  include Singleton

  def initialize
    super(File.dirname(__FILE__) + "/../movie.db")

    self.results_as_hash = true
    self.type_translation = true
  end

  def self.execute(*args)
    self.instance.execute(*args)
  end
end

# 1. Obtain the cast list for the movie 'Rain Man'; order by the actors'
#    names.
def rain_man_cast
  MovieDatabase.execute(<<-SQL)
  SELECT
    actor.name
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON movie.id = casting.movieid
  WHERE
    movie.title = 'Rain Man'
  ORDER BY
    actor.name
SQL
end

# 2. List the films in which 'Harrison Ford' has appeared; order by
# movie title.
def harrison_ford_films
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON movie.id = casting.movieid
  WHERE
    actor.name = 'Harrison Ford'
  ORDER BY
    movie.title
SQL
end

# 3. For each film released in 2000 or later in which 'Christopher
#    Walken' has appeared, list the movie title and the year. Order by
#    movie title.
def christopher_walken_21st_century_films
  MovieDatabase.execute(<<-SQL)
    SELECT
      movie.title, movie.yr
    FROM
      actor
    JOIN
      casting ON actor.id = casting.actorid
    JOIN
      movie ON movie.id = casting.movieid
    WHERE
      actor.name = 'Christopher Walken'
    AND
      movie.yr >= 2000
    ORDER BY
      movie.title
SQL
end

# 4. List the films together with the leading star for all 1962
# films. Order by movie title.
def leading_star_for_1962_films
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title, actor.name
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON movie.id = casting.movieid
  WHERE
    movie.yr = 1962
  AND
    casting.ord = 1
  ORDER BY
    movie.title
SQL
end

# 5. There is a film from 2012 in our database for which there is no
# associated casting information. Give the id and title of this movie.
def unknown_actors_2012
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.id, movie.title
  FROM
    movie
  LEFT OUTER JOIN
    casting ON movie.id = casting.movieid
  WHERE
    casting.actorid IS NULL
  AND
    yr = 2012

SQL
end

# 6. Obtain a list in alphabetical order of actors who've had >=26
# starring roles. Order by actor name.
def biggest_stars
  MovieDatabase.execute(<<-SQL)
  SELECT
    actor.name, COUNT(*) as count
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON movie.id = casting.movieid
  WHERE
    casting.ord = 1
  GROUP BY
    actor.name
  HAVING
    COUNT(*) >= 26
  ORDER BY
    actor.name
SQL
end

# 7. List the movie title and the leading actor for all of the films
#    in which 'Ben Affleck' appeared but not as the lead actor.
def stars_working_with_ben_affleck
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.title, actor.name
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON movie.id = casting.movieid
  WHERE
    casting.ord = 1
  AND
    movie.id in (
      SELECT
        movie.id
      FROM
        actor
      JOIN
        casting ON actor.id = casting.actorid
      JOIN
        movie ON movie.id = casting.movieid
      WHERE
        actor.name = 'Ben Affleck'
      AND
        casting.ord > 1
    )
  ORDER BY
    movie.title
SQL
end

# 8. Which were the busiest years for 'John Travolta'? List the year
# and the number of movies he made each year, for any year in which he
# made >2 movies. Order by year.
def busiest_john_travolta_years
  MovieDatabase.execute(<<-SQL)
  SELECT
    movie.yr, COUNT(*) as count
  FROM
    actor
  JOIN
    casting ON actor.id = casting.actorid
  JOIN
    movie ON movie.id = casting.movieid
  WHERE
    actor.name = 'John Travolta'
  GROUP BY
    movie.yr
  HAVING
    count(*) > 2
SQL
end
