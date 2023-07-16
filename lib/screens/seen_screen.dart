import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_app/models/movie_model.dart';
import 'package:movie_search_app/providers/movies_provider.dart';
import 'package:movie_search_app/widgets/movies_list.dart';

class SeenScreen extends ConsumerStatefulWidget {
  const SeenScreen({super.key});

  @override
  ConsumerState<SeenScreen> createState() {
    return _SeenScreenState();
  }
}

class _SeenScreenState extends ConsumerState<SeenScreen> {
  String searchInputValue = '';

  void searchInputChanged(String value) {
    setState(() {
      searchInputValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> moviesToShow = [];

    List<Movie> haveSeenMovies = ref.watch(haveSeenMoviesProvider);

    if (haveSeenMovies.isNotEmpty) {
      moviesToShow = haveSeenMovies;
    }

    if (searchInputValue.isNotEmpty) {
      moviesToShow = haveSeenMovies
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
                  hintText: 'What you\'ve been watching?',
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
