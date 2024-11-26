import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase {
  // Static method to get database connection
  static Future<Database> getConnection() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'movies.db');
    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE movies (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            faixaEtaria INTEGER,
            duracao INTEGER,
            pontuacao INTEGER,
            ano INTEGER,
            url TEXT,
            titulo TEXT,
            genero TEXT,
            descricao TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Singleton instance
  static final MovieDatabase instance = MovieDatabase._init();
  static Database? _database;

  MovieDatabase._init();

  // Getter for the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await getConnection();
    return _database!;
  }

  // Create (Insert) Operation
  Future<int> insertMovie(Map<String, dynamic> movie) async {
    final db = await database;
    return await db.insert('movies', movie,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Read (Query) Operations
  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final db = await database;
    return await db.query('movies');
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final movies = await db.query(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );
    return movies.isNotEmpty ? movies.first : null;
  }

  Future<List<Map<String, dynamic>>> getMoviesByGenero(String genero) async {
    final db = await database;
    return await db.query('movies', where: 'genero = ?', whereArgs: [genero]);
  }

  Future<List<Map<String, dynamic>>> getMoviesByAno(int ano) async {
    final db = await database;
    return await db.query('movies', where: 'ano = ?', whereArgs: [ano]);
  }

  // Update Operation
  Future<int> updateMovie(Map<String, dynamic> movie) async {
    final db = await database;
    return await db.update(
      'movies',
      movie,
      where: 'id = ?',
      whereArgs: [movie['id']],
    );
  }

  // Delete Operation
  Future<int> deleteMovie(int id) async {
    final db = await database;
    return await db.delete(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Example usage to test database operations
void main() async {
  final db = MovieDatabase.instance;

  // Insert a movie
  Map<String, dynamic> newMovie = {
    'faixaEtaria': 12,
    'duracao': 120,
    'pontuacao': 8,
    'ano': 2023,
    'url': 'https://example.com/movie',
    'titulo': 'Meu Filme',
    'genero': 'Ação',
    'descricao': 'Um filme de ação emocionante.'
  };

  int movieId = await db.insertMovie(newMovie);
  print('Filme inserido com ID: $movieId');

  // Get all movies
  List<Map<String, dynamic>> allMovies = await db.getAllMovies();
  print('Filmes no banco de dados:');
  for (var movie in allMovies) {
    print(movie);
  }

  // Get movie by ID
  Map<String, dynamic>? movieById = await db.getMovieById(movieId);
  if (movieById != null) {
    print('Filme com ID $movieId encontrado: $movieById');
  } else {
    print('Nenhum filme encontrado com ID $movieId.');
  }
}
