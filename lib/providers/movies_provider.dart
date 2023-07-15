import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_app/db/movies_db.dart';
import 'package:movie_search_app/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';

class MoviesProvider extends StateNotifier<List<Movie>> {
  MoviesProvider({this.db}) : super([]);

  late Database? db;

  Future<Database> getDb() async {
    return await MoviesDb.getDatabase();
  }

  Future<void> loadMovies() async {
    db ??= await getDb();

    final data = await db!.query('movies');

    final movies = data
        .map((row) => Movie(
              imdbID: row['imdbID'] as String,
              title: row['title'] as String,
              year: row['year'] as String,
              country: row['country'] as String,
              genre: row['genre'] as String,
              runtime: row['runtime'] as String,
              directors: row['directors'] as String,
              writers: row['writers'] as String,
              actors: row['actors'] as String,
              plot: row['plot'] as String,
              ratings: jsonDecode(row['ratings'] as String)
                  as List<Map<String, String>>,
              boxoffice: row['boxoffice'] as String,
              rated: row['rated'] as String,
              poster: row['poster'] as String,
              isWatchLater: row['isWatchLater'] != 0,
              haveSeen: row['haveSeen'] != 0,
              userRating: row['userRating'] as int,
            ))
        .toList();

    state = movies;
  }

  void addMovie(Movie movie) async {
    db ??= await getDb();

    db!.insert('movies', {
      // 'id': newMovie.id,
      // 'title': newMovie.title,
    });

    // state = [newMovie, ...state];
  }

  void updateMovie(Movie movie) async {
    db ??= await getDb();

    db!.update('movies', {});

    // state = [newMovie, ...state];
  }
}

final moviesProvider = StateNotifierProvider<MoviesProvider, List<Movie>>(
    (ref) => MoviesProvider());
