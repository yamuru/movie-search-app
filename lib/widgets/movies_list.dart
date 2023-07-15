import 'package:flutter/material.dart';
import 'package:movie_search_app/models/movie_model.dart';
import 'package:movie_search_app/widgets/movies_list_item.dart';

class MoviesList extends StatelessWidget {
  const MoviesList(this.movies, {super.key});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (ctx, index) => MoviesListItem(movies[index]),
      padding: const EdgeInsets.only(top: 10),
    );
  }
}
