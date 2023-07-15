import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

final dbFields = [
  'imdbID TEXT PRIMARY KEY',
  'title TEXT',
  'year INTEGER',
  'country TEXT',
  'genre TEXT',
  'runtime TEXT',
  'directors TEXT',
  'writers TEXT',
  'actors TEXT',
  'description TEXT',
  'plot TEXT',
  'ratings TEXT',
  'boxoffice TEXT',
  'rated TEXT',
  'poster TEXT',
  'isWatchLater INTEGER',
  'haveSeen INTEGER',
  'userRating INTEGER'
];

class MoviesDb {
  static Future<void> createDatabase(Database db, int version) {
    String dbCreationQuery = 'CREATE TABLE movies(';

    for (int i = 0; i < dbFields.length; i++) {
      dbCreationQuery += dbFields[i];
    }

    dbCreationQuery += ')';

    return db.execute(dbCreationQuery);
  }

  static Future<Database> getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'movies.db'),
      onCreate: createDatabase,
      version: 1,
    );
    return db;
  }
}
