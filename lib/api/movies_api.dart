import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movie_search_app/models/movie_model.dart';
import '../utils/env.dart';

final baseUrl = 'http://www.omdbapi.com/?apikey=${Env.myApiKey}';
final forbiddenSymbols = [';', ":", '!', '&', '?', '\'', '"'];

String excludeForbiddenQuerySymbols(String query) {
  final String queryTrimmed = query.trim();
  final List<String> querySplitted = queryTrimmed.split('');
  final String cleanQuery = querySplitted
      .where((symbol) => !forbiddenSymbols.contains(symbol))
      .join('');

  return cleanQuery;
}

class MoviesApi {
  const MoviesApi();

  static Future<List<Movie>> searchMovies(String searchQuery) async {
    final String cleanQuery = excludeForbiddenQuerySymbols(searchQuery);

    final url = Uri.parse('$baseUrl&type=movie&s=$cleanQuery');
    final response = await http.get(url);

    final List? searchResult = jsonDecode(response.body)['Search'];

    final List<Movie> movies = [];

    if (searchResult == null) return [];

    for (int i = 0; i < searchResult.length; i++) {
      var movie = searchResult[i];

      movies.add(
        Movie(
          imdbID: movie['imdbID'],
          title: movie['Title'],
          year: movie['Year'],
          poster: movie['Poster'],
        ),
      );
    }

    return movies;
  }

  static Future<Movie> movieDetailsById(String imdbID) async {
    final url = Uri.parse('$baseUrl&type=movie&plot=short&i=$imdbID');
    final response = await http.get(url);

    final Map<String, dynamic> movieFound = jsonDecode(response.body);

    if (movieFound['Response'] == 'False') {
      return Movie(
        imdbID: imdbID,
        title: 'Movie not found!',
      );
    }

    final List ratingsAsList = movieFound['Ratings'];

    final Movie movie = Movie(
      imdbID: imdbID,
      title: movieFound['Title']!,
      year: movieFound['Year']!,
      poster: movieFound['Poster']!,
      actors: movieFound['Actors']!,
      boxoffice: movieFound['BoxOffice']!,
      country: movieFound['Country']!,
      directors: movieFound['Director']!,
      genre: movieFound['Genre']!,
      plot: movieFound['Plot']!,
      rated: movieFound['Rated']!,
      ratings: ratingsAsList,
      runtime: movieFound['Runtime']!,
      writers: movieFound['Writer']!,
    );

    return movie;
  }
}
