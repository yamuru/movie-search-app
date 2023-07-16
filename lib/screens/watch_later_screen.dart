import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_app/models/movie_model.dart';
import 'package:movie_search_app/providers/movies_provider.dart';
import 'package:movie_search_app/widgets/movies_list.dart';

class WatchLaterScreen extends ConsumerStatefulWidget {
  const WatchLaterScreen({super.key});

  @override
  ConsumerState<WatchLaterScreen> createState() {
    return _WatchLaterScreenState();
  }
}

class _WatchLaterScreenState extends ConsumerState<WatchLaterScreen> {
  String searchInputValue = '';

  void searchInputChanged(String value) {
    setState(() {
      searchInputValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> moviesToShow = [];

    List<Movie> watchLaterMovies = ref.watch(watchLaterMoviesProvider);

    if (watchLaterMovies.isNotEmpty) {
      moviesToShow = watchLaterMovies;
    }

    if (searchInputValue.isNotEmpty) {
      moviesToShow = watchLaterMovies
          .where((el) =>
              el.title.toLowerCase().contains(searchInputValue.toLowerCase()))
          .toList();
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
                  hintText: 'What did you want to watch later?',
                  counterStyle: TextStyle(
                    color: Colors.transparent,
                  )),
            ),
            Expanded(
                child: moviesToShow.isEmpty
                    ? Center(
                        child: Text(
                          'No movies found',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : MoviesList(moviesToShow)),
          ],
        ),
      ),
    );
  }
}
