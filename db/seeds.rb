require 'json'
require 'net/http'

url = URI('http://tmdb.lewagon.com/movie/top_rated')

top_movies = JSON.parse(URI.open(url).read)['results']

puts 'Cleaning database...'
Movie.destroy_all

puts "Creating #{top_movies.size} movies..."
top_movies.each do |movie|
  Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end

puts 'Finished!'
