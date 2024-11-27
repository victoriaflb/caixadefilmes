import 'movie_connection.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Getter for the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await MovieDatabase.getConnection();
    return _database!;
  }

  // Create (Insert) Operation
  Future<int> insertMovie(Map<String, dynamic> movie) async {
    try {
      final db = await database;
      return await db.insert('movies', movie,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (ex) {
      print("Erro ao inserir filme no banco de dados: $ex");
      rethrow;
    }
  }

  // Read (Query) Operations
  Future<List<Map<String, dynamic>>> getAllMovies() async {
    try {
      final db = await database;
      return await db.query('movies');
    } catch (ex) {
      print("Erro ao buscar filmes no banco de dados: $ex");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    try {
      final db = await database;
      final movies = await db.query(
        'movies',
        where: 'id = ?',
        whereArgs: [id],
      );
      return movies.isNotEmpty ? movies.first : null;
    } catch (ex) {
      print("Erro ao buscar filme por ID no banco de dados: $ex");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getMoviesByGenero(String genero) async {
    try {
      final db = await database;
      return await db.query('movies', where: 'genero = ?', whereArgs: [genero]);
    } catch (ex) {
      print("Erro ao buscar filmes por gênero no banco de dados: $ex");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getMoviesByAno(int ano) async {
    try {
      final db = await database;
      return await db.query('movies', where: 'ano = ?', whereArgs: [ano]);
    } catch (ex) {
      print("Erro ao buscar filmes por ano no banco de dados: $ex");
      return [];
    }
  }

  // Update Operation
  Future<int> updateMovie(Map<String, dynamic> movie) async {
    try {
      final db = await database;
      return await db.update(
        'movies',
        movie,
        where: 'id = ?',
        whereArgs: [movie['id']],
      );
    } catch (ex) {
      print("Erro ao atualizar filme no banco de dados: $ex");
      return 0;
    }
  }

  // Delete Operation
  Future<int> deleteMovie(int id) async {
    try {
      final db = await database;
      return await db.delete(
        'movies',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (ex) {
      print("Erro ao deletar filme no banco de dados: $ex");
      return 0;
    }
  }
}
