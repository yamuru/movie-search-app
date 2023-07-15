import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_search_app/api/movies_api.dart';
import 'package:movie_search_app/models/movie_model.dart';
import 'package:movie_search_app/widgets/movies_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? timer;
  String searchInputValue = '';
  List<Movie> movies = [];

  Future<void> searchMovieByInput() async {
    final List<Movie> newMovies =
        await MoviesApi.searchMovies(searchInputValue);

    setState(() => movies = newMovies);
  }

  void setTimerToSearch() {
    timer?.cancel();

    if (searchInputValue.isNotEmpty) {
      timer = Timer(const Duration(seconds: 2), searchMovieByInput);
    }
  }

  void searchInputChanged(String value) {
    setState(() => movies = []);

    searchInputValue = value;

    setTimerToSearch();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'Use the field above to search for movies.',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );

    if (movies.isNotEmpty) {
      content = MoviesList(movies);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              maxLength: 32,
              onChanged: searchInputChanged,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Find a movie...',
                  counterStyle: TextStyle(
                    color: Colors.transparent,
                  )),
            ),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
