
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Banco de Dados
Future<Database> getDatabase(){
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, "movies.db");
    return openDatabase(path, onCreate: (db, version) {
      db.execute("CREATE TABLE movies("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "faixaEtaria INTEGER,"
          "duracao INTEGER,"
          "ano INTEGER,"
          "pontuacao INTEGER,"
          "titulo TEXT,"
          "genero TEXT,"
          "descricao TEXT,"
          "url TEXT)");
    }, version: 1);
  });
  }

  // Inserir



