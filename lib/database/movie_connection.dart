import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';  // Importando a versão web
import 'package:path/path.dart'; // Para manipulação de caminhos
import 'package:sqflite/sqflite.dart'; // Para plataformas móveis

class MovieDatabase {
  // Static method to get database connection
  static Future<Database> getConnection() async {
    try {
      // Inicialize o databaseFactory para web
      databaseFactory = databaseFactoryFfiWeb;

      String path = await getDatabasesPath();
      String dbPath = join(path, 'movies.db');

      // Conectando-se ao banco de dados
      Database db = await openDatabase(
        dbPath,
        version: 1,
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
      );
      print("Conexão com o banco de dados estabelecida com sucesso.");
      return db;
    } catch (ex) {
      print("Erro ao conectar com o banco de dados: $ex");
      rethrow;  // Re-throw to propagate the error if needed elsewhere
    }
  }
}
