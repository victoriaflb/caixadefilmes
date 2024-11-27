import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase {
  // Static method to get database connection
  static Future<Database> getConnection() async {
    try {
      String path = await getDatabasesPath();
      String dbPath = join(path, 'movies.db');
      Database db = await openDatabase(
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
      print("Conexão com o banco de dados estabelecida com sucesso.");
      return db;
    } catch (ex) {
      print("Erro ao conectar com o banco de dados: $ex");

      rethrow;  // Re-throw to propagate the error if needed elsewhere
    }
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
    try {
      final db = await database;
      return await db.insert('movies', movie,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (ex) {
      print("Erro ao inserir filme no banco de dados: $ex");
      rethrow;  // Re-throw to propagate the error if needed elsewhere
    }
  }

  // Read (Query) Operations
  Future<List<Map<String, dynamic>>> getAllMovies() async {
    try {
      final db = await database;
      return await db.query('movies');
    } catch (ex) {
      print("Erro ao buscar filmes no banco de dados: $ex");
      return [];  // Return an empty list if there's an error
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
      return 0;  // Return 0 if update fails
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
      return 0;  // Return 0 if delete fails
    }
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

  try {
    int movieId = await db.insertMovie(newMovie);
    print('Filme inserido com ID: $movieId');
  } catch (e) {
    print("Erro ao tentar inserir o filme: $e");
  }

  // Get all movies
  try {
    List<Map<String, dynamic>> allMovies = await db.getAllMovies();
    print('Filmes no banco de dados:');
    for (var movie in allMovies) {
      print(movie);
    }
  } catch (e) {
    print("Erro ao buscar filmes: $e");
  }

  // Get movie by ID
  try {
    Map<String, dynamic>? movieById = await db.getMovieById(1);
    if (movieById != null) {
      print('Filme com ID 1 encontrado: $movieById');
    } else {
      print('Nenhum filme encontrado com ID 1.');
    }
  } catch (e) {
    print("Erro ao buscar filme por ID: $e");
  }
}
