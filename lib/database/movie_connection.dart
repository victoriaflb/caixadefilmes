import 'package:path/path.dart'; // Para manipulação de caminhos
import 'package:sqflite/sqflite.dart'; // Para bancos de dados móveis

class MovieDatabase {
  static Future<Database> getConnection() async {
    try {
      String path = await getDatabasesPath();
      print("Caminho do banco de dados: $path");
      String dbPath = join(path, 'movies1.db');

      // await deleteDatabase(dbPath); // Remova essa linha após testar

      Database db = await openDatabase(
        dbPath,
        version: 3, // Alterar versão para testar recriação
        onCreate: (db, version) async {
          try {
            await db.execute('''
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
            print("Tabela 'movies' criada com sucesso.");
          } catch (e) {
            print("Erro ao criar tabela 'movies': $e");
          }
        },
      );
      print("Conexão com o banco de dados estabelecida com sucesso.");
      return db;
    } catch (ex) {
      print("Erro ao conectar com o banco de dados: $ex");
      rethrow;
    }
  }
}
