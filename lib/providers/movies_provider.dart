import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_app/db/movies_db.dart';
import 'package:movie_search_app/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';

class MoviesProvider extends StateNotifier<List<Movie>> {
  MoviesProvider({this.db}) : super(const []);

  Database? db;

  Future<void> loadMovies() async {
    db ??= await MoviesDb.getDatabase();

    final data = await db!.query('movies');

    final movies = data
        .map((row) => Movie(
              imdbID: row['imdbID'] as String,
              title: row['title'] as String,
              year: '${row['year']}',
              country: row['country'] as String,
              genre: row['genre'] as String,
              runtime: row['runtime'] as String,
              directors: row['directors'] as String,
              writers: row['writers'] as String,
              actors: row['actors'] as String,
              plot: row['plot'] as String,
              ratings: jsonDecode(row['ratings'] as String) as List,
              boxoffice: row['boxoffice'] as String,
              rated: row['rated'] as String,
              poster: row['poster'] as String,
              isWatchLater: row['isWatchLater'] != 0,
              haveSeen: row['haveSeen'] != 0,
              userRating: row['userRating'] as int?,
            ))
        .toList();

    state = movies;
  }

  void addMovie(
    Movie movie, {
    isWatchLater = false,
    haveSeen = false,
    userRating = 0,
  }) async {
    db ??= await MoviesDb.getDatabase();

    db!.insert('movies', {
      'imdbID': movie.imdbID,
      'title': movie.title,
      'year': movie.year,
      'country': movie.country,
      'genre': movie.genre,
      'runtime': movie.runtime,
      'directors': movie.directors,
      'writers': movie.writers,
      'actors': movie.actors,
      'plot': movie.plot,
      'ratings': jsonEncode(movie.ratings),
      'boxoffice': movie.boxoffice,
      'rated': movie.rated,
      'poster': movie.poster,
      'isWatchLater': isWatchLater,
      'haveSeen': haveSeen,
      'userRating': userRating,
    });

    state = [...state, movie];
  }

  void updateMovie(
    Movie movie, {
    isWatchLater,
    haveSeen,
    userRating,
  }) async {
    db ??= await MoviesDb.getDatabase();

    if (state.indexWhere((el) => el.imdbID == movie.imdbID) == -1) {
      return addMovie(
        movie,
        isWatchLater: isWatchLater,
        haveSeen: haveSeen,
        userRating: userRating,
      );
    }

    isWatchLater = isWatchLater ?? movie.isWatchLater;
    haveSeen = haveSeen ?? movie.haveSeen;
    userRating = userRating ?? movie.userRating;

    db!.update(
      'movies',
      {
        'imdbID': movie.imdbID,
        'title': movie.title,
        'year': movie.year,
        'country': movie.country,
        'genre': movie.genre,
        'runtime': movie.runtime,
        'directors': movie.directors,
        'writers': movie.writers,
        'actors': movie.actors,
        'plot': movie.plot,
        'ratings': jsonEncode(movie.ratings),
        'boxoffice': movie.boxoffice,
        'rated': movie.rated,
        'poster': movie.poster,
        'isWatchLater': isWatchLater ? 1 : 0, // sqflite doesn't accept bool,
        'haveSeen': haveSeen ? 1 : 0, // bools in sqflite are 1 or 0.
        'userRating': userRating,
      },
      where: 'imdbID = ?',
      whereArgs: [movie.imdbID],
    );

    Movie updatedMovie = movie.copyWith(
      newIsWatchLater: isWatchLater,
      newHaveSeen: haveSeen,
      newUserRating: userRating,
    );

    List<Movie> moviesNewState = state
        .where(
          (movieElement) => movieElement.imdbID != movie.imdbID,
        )
        .toList();

    state = [...moviesNewState, updatedMovie];
  }
}

final moviesProvider = StateNotifierProvider<MoviesProvider, List<Movie>>(
    (ref) => MoviesProvider());

final watchLaterMoviesProvider = Provider((ref) {
  final movies = ref.watch(moviesProvider);

  return movies.where((movie) => movie.isWatchLater).toList();
});

final haveSeenMoviesProvider = Provider((ref) {
  final movies = ref.watch(moviesProvider);

  return movies.where((movie) => movie.haveSeen).toList();
});
