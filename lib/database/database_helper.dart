import 'package:caixadefilmes/database/movie_connection.dart';
import 'package:sqflite/sqflite.dart';
import 'model/movie.dart';

class MovieDao {
  static Future<int?> insertMovie(Movie movie) async {
    try {
      Database db = await MovieDatabase.getConnection();
      return await db.insert('movies', movie.toMap());
    } catch (ex) {
      print(ex);
      print("ENTREI NO BANCO");
      return null;
    }
  }

  static Future<List<Movie>?> getAllMovies() async {
    try {
      Database db = await MovieDatabase.getConnection();
      List<Map<String, Object?>> listMap = await db.query('movies');
      List<Movie> movies = [];
      for (Map<String, Object?> map in listMap) {
        movies.add(Movie.fromMap(map));
      }
      return movies;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  static Future<int?> updateMovie(int id, Movie movie) async {
    try {
      Database db = await MovieDatabase.getConnection();
      return await db.update('movies', movie.toMap(), where: 'id = ?', whereArgs: [id]);
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  static Future<int?> deleteMovie(int id) async {
    try {
      Database db = await MovieDatabase.getConnection();
      return await db.delete('movies', where: 'id = ?', whereArgs: [id]);
    } catch (ex) {
      print(ex);
      return null;
    }
  }
}