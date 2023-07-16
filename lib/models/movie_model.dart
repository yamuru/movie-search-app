class Movie {
  Movie({
    required this.imdbID,
    this.title = '',
    this.year = '',
    this.poster = '',
    this.country = '',
    this.genre = '',
    this.runtime = '',
    this.directors = '',
    this.writers = '',
    this.actors = '',
    this.plot = '',
    this.ratings = const [],
    this.boxoffice = '',
    this.rated = '',
    this.isWatchLater = false,
    this.haveSeen = false,
    this.userRating = 0,
  });

  final String imdbID;
  final String title;
  final String year;
  final String country;
  final String genre;
  final String runtime;
  final String directors;
  final String writers;
  final String actors;
  final List ratings;
  final String boxoffice;
  final String rated;
  final String poster;
  final String plot;
  bool isWatchLater;
  bool haveSeen;
  int? userRating;

  Movie copyWith({newIsWatchLater, newHaveSeen, newUserRating}) {
    return Movie(
      imdbID: imdbID,
      title: title,
      year: year,
      country: country,
      genre: genre,
      runtime: runtime,
      directors: directors,
      writers: writers,
      actors: actors,
      ratings: ratings,
      boxoffice: boxoffice,
      rated: rated,
      poster: poster,
      plot: plot,
      isWatchLater: newIsWatchLater ?? isWatchLater,
      haveSeen: newHaveSeen ?? haveSeen,
      userRating: newUserRating ?? userRating,
    );
  }
}
