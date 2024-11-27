class Movie {
  int? id;
  int faixaEtaria;
  int duracao;
  int pontuacao;
  int ano;
  String url;
  String titulo;
  String genero;
  String descricao;

  Movie({
    this.id,
    required this.faixaEtaria,
    required this.duracao,
    required this.pontuacao,
    required this.ano,
    required this.url,
    required this.titulo,
    required this.genero,
    required this.descricao,
  });


  // Função para converter um mapa (Map) para um objeto Movie
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      faixaEtaria: map['faixaEtaria'],
      duracao: map['duracao'],
      pontuacao: map['pontuacao'],
      ano: map['ano'],
      url: map['url'],
      titulo: map['titulo'],
      genero: map['genero'],
      descricao: map['descricao'],
    );
  }

  // Função para converter um objeto Movie para um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'faixaEtaria': faixaEtaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'ano': ano,
      'url': url,
      'titulo': titulo,
      'genero': genero,
      'descricao': descricao,
    };
  }
}