import 'package:flutter/material.dart';
import 'package:movie_search_app/models/movie_model.dart';
import 'package:movie_search_app/screens/movie_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class MoviesListItem extends StatelessWidget {
  const MoviesListItem(this.movie, {super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: InkWell(
        onTap: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MovieDetailsScreen(
                imdbID: movie.imdbID,
              ),
            ),
          );
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: Theme.of(context).highlightColor,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          height: 225,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(movie.poster),
                fit: BoxFit.fitHeight,
                width: 120,
                height: 180,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 180,
                    color: Colors.grey,
                    child: const Icon(Icons.image_not_supported,
                        color: Colors.black45),
                  );
                },
              ),
              const SizedBox(width: 28),
              Expanded(
                child: Text(
                  '${movie.title} (${movie.year})',
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
