import 'package:flutter/material.dart';
import 'package:movie_search_app/api/movies_api.dart';
import 'package:movie_search_app/models/movie_model.dart';
import 'package:transparent_image/transparent_image.dart';

enum Source {
  search,
  db,
}

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({
    super.key,
    required this.movie,
    required this.source,
  });

  final Movie movie;
  final Source source;

  @override
  State<MovieDetailsScreen> createState() {
    return _MovieDetailsScreenState();
  }
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Movie movie;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    switch (widget.source) {
      case Source.search:
        movieDetailsFromApi();
      case Source.db:
        movieDetailsFromDb();
      default:
        movie =
            const Movie(imdbID: '', title: 'Movie detaild can\'t be fetched');
    }
  }

  void movieDetailsFromApi() async {
    MoviesApi.movieDetailsById(widget.movie.imdbID).then((movieFromApi) {
      setState(() {
        movie = movieFromApi;
        isLoading = false;
      });
    });
  }

  void movieDetailsFromDb() async {
    return;
  }

  Widget descriptionRow(field, value,
      {double verticalPadding = 6, double valueWidth = 200}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$field:',
            textAlign: TextAlign.left,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(),
          SizedBox(
            width: valueWidth,
            child: Text(
              value,
              textAlign: TextAlign.right,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'Loading...',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );

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
                    Ink(
                      decoration: ShapeDecoration(
                        color: Theme.of(context).focusColor,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.watch_later_outlined, size: 25),
                        onPressed: () {},
                      ),
                    ),
                    Ink(
                      decoration: ShapeDecoration(
                        color: Theme.of(context).focusColor,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.visibility_outlined, size: 25),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 38),
                descriptionRow('Year', movie.year),
                descriptionRow('Country', movie.country),
                descriptionRow('Genre', movie.genre),
                descriptionRow('Director', movie.directors),
                descriptionRow('Writers', movie.writers),
                descriptionRow('Actors', movie.actors),
                descriptionRow('Box Office', movie.boxoffice),
                descriptionRow('Runtime', movie.runtime),
                descriptionRow('Rated', movie.rated),
                const SizedBox(height: 50),
                Text(
                  movie.plot,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleMedium,
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
                for (int i = 0; i < movie.ratings.length; i++)
                  descriptionRow(
                      movie.ratings[i]['Source'], movie.ratings[i]['Value'],
                      valueWidth: 100),
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
