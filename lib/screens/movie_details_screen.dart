import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search_app/api/movies_api.dart';
import 'package:movie_search_app/models/movie_model.dart';
import 'package:movie_search_app/providers/movies_provider.dart';
import 'package:movie_search_app/widgets/icon_button.dart';
import 'package:movie_search_app/widgets/movie_info.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetailsScreen extends ConsumerStatefulWidget {
  const MovieDetailsScreen({
    super.key,
    required this.imdbID,
  });

  final String imdbID;

  @override
  ConsumerState<MovieDetailsScreen> createState() {
    return _MovieDetailsScreenState();
  }
}

class _MovieDetailsScreenState extends ConsumerState<MovieDetailsScreen> {
  late Movie movie;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    List<Movie> movies = ref.read(moviesProvider);
    bool movieCanBeFoundInDb =
        movies.indexWhere((el) => el.imdbID == widget.imdbID) >= 0;

    if (movieCanBeFoundInDb) {
      movieDetailsFromDb();
    } else {
      movieDetailsFromApi();
    }
  }

  void movieDetailsFromApi() async {
    MoviesApi.movieDetailsById(widget.imdbID).then((movieFromApi) {
      setState(() {
        movie = movieFromApi;
        isLoading = false;
      });
    });
  }

  void movieDetailsFromDb() async {
    List<Movie> movies = ref.read(moviesProvider);
    Movie movieDetails = movies.firstWhere((el) => el.imdbID == widget.imdbID);
    setState(() {
      movie = movieDetails;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'Loading...',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );

    final Map<String, String> ratings = {};

    for (int i = 0; i < movie.ratings.length; i++) {
      ratings[movie.ratings[i]['Source']] = movie.ratings[i]['Value'];
    }

    if (!isLoading) {
      content = Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 35, right: 35),
            child: Column(
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 40),
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(movie.poster),
                  fit: BoxFit.fitHeight,
                  width: 200,
                  height: 300,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 200,
                      height: 300,
                      color: Colors.grey,
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.black45),
                    );
                  },
                ),
                const SizedBox(height: 38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IcButton(
                      isActive: movie.isWatchLater,
                      icon: Icons.watch_later_outlined,
                      iconWhenActive: Icons.watch_later,
                      onPressed: () {
                        setState(() {
                          movie.isWatchLater = !movie.isWatchLater;
                        });
                        ref.read(moviesProvider.notifier).updateMovie(
                              movie,
                              isWatchLater: movie.isWatchLater,
                            );
                      },
                    ),
                    IcButton(
                      isActive: movie.haveSeen,
                      icon: Icons.visibility_outlined,
                      iconWhenActive: Icons.visibility,
                      onPressed: () {
                        setState(() {
                          movie.haveSeen = !movie.haveSeen;
                          ref.read(moviesProvider.notifier).updateMovie(
                                movie,
                                haveSeen: movie.haveSeen,
                              );
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 38),
                MovieInfo(
                  fields: {
                    'Year': movie.year,
                    'Country': movie.country,
                    'Genre': movie.genre,
                    'Director': movie.directors,
                    'Writers': movie.writers,
                    'Actors': movie.actors,
                    'Box Office': movie.boxoffice,
                    'Runtime': movie.runtime,
                    'Rated': movie.rated,
                  },
                  valueWidth: 200,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    movie.plot,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Ratings',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 10),
                MovieInfo(
                  fields: ratings,
                  valueWidth: 100,
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(body: content),
    );
  }
}
