import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:caixadefilmes/database/model/movie.dart';  
import 'package:path_provider/path_provider.dart';
// Importa o modelo Movie

class DatabaseHelper {
  static final _databaseName = "MovieDB.db"; // Nome do banco de dados
  static final _databaseVersion = 1; // Versão do banco de dados
  static final table = 'movies'; // Nome da tabela  
  static final columnId = 'id'; // Nome da coluna id
  static final columnFaixaEtaria = 'faixaEtaria';
  static final columnDuracao = 'duracao';
  static final columnPontuacao = 'pontuacao';
  static final columnAno = 'ano';
  static final columnUrl = 'url';
  static final columnTitulo = 'titulo';
  static final columnGenero = 'genero';
  static final columnDescricao = 'descricao';

  // Torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  
  // Tem somente uma referência ao banco de dados
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database!;
  }  

  // Abre o banco de dados e o cria se ele não existir
_initDatabase() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, _databaseName);
  print("Path do banco de dados: $path");  // Verifique o caminho do banco de dados
  return await openDatabase(path,
      version: _databaseVersion,
      onCreate: _onCreate);
}


  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnFaixaEtaria INTEGER,
            $columnDuracao INTEGER,
            $columnPontuacao INTEGER,
            $columnAno INTEGER,
            $columnUrl TEXT,
            $columnTitulo TEXT,
            $columnGenero TEXT,
            $columnDescricao TEXT
          )
          ''');
  }

  // Métodos Helper
  //----------------------------------------------------

  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(Movie movie) async {
    Database db = await instance.database;
    return await db.insert(table, movie.toMap());
  }

  // Retorna todas as linhas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<Movie>> queryAllRows() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    // Converte os mapas para uma lista de objetos Movie
    return List.generate(maps.length, (i) {
      return Movie.fromMap(maps[i]);
    });
  }

  // Retorna a contagem de linhas na tabela
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // Atualiza uma linha especificada pelo id.
  Future<int> update(Movie movie) async {
    Database db = await instance.database;
    return await db.update(table, movie.toMap(),
        where: '$columnId = ?', whereArgs: [movie.id]);
  }

  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}

void main() async {
  // Criação de um novo filme
  Movie newMovie = Movie(
    faixaEtaria: 12,
    duracao: 120,
    pontuacao: 85,
    ano: 2023,
    url: 'https://example.com',
    titulo: 'Exemplo de Filme',
    genero: 'Ação',
    descricao: 'Um filme de ação emocionante.',
  );

  // Inserção no banco de dados
  int movieId = await DatabaseHelper.instance.insert(newMovie);
  print('Filme inserido com ID: $movieId');

  // Consultar todos os filmes
  List<Movie> movies = await DatabaseHelper.instance.queryAllRows();
  print('Filmes no banco de dados:');
  for (var movie in movies) {
    print(movie.titulo);
  }

  // Atualização de um filme
  newMovie.titulo = 'Novo Título de Filme';
  await DatabaseHelper.instance.update(newMovie);
  print('Filme atualizado');

  // Excluindo um filme
  await DatabaseHelper.instance.delete(movieId);
  print('Filme excluído');
}