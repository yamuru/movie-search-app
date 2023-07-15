class Movie {
  const Movie({
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
  final bool isWatchLater;
  final bool haveSeen;
  final int userRating;
}
