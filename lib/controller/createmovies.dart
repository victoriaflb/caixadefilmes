import 'package:flutter/material.dart';

class CreateMoviesController {
  // Mapa de categorias com filmes
  final Map<String, List<Map<String, dynamic>>> movieCategories = {
    'Em Alta': [
      {
        'title': 'Velozes e Furiosos 8',
        'genre': 'Ação, Aventura e Crime',
        'imageUrl':
            'https://i0.statig.com.br/bancodeimagens/c0/ql/wl/c0qlwl4vwfwebs2dubrqb5qpa.jpg',
        'rating': 4.5,
        'ano': '2017',
        'duration': '2h 16min',
        'description': 'Depois da aposentadoria de Brian e Mia, Dom e Letty aproveitam a lua de mel e levam uma vida pacata e normal. Mas a adrenalina do passado volta com tudo quando uma mulher misteriosa obriga Dom a retornar ao mundo do crime e da velocidade.'
      },
      {
        'title': 'Harry Potter e o Cálice de Fogo',
        'genre': 'Aventura, Fantasia',
        'imageUrl':
            'https://i0.wp.com/villarica.com.br/wp-content/uploads/2022/09/HARRY-POTTER-E-O-CA%CC%81LICE-DE-FOGO-.webp?fit=1000%2C1500&ssl=1',
        'rating': 4.0,
        'ano': '2005',
        'duration': '2h 37min',
        'description': 'Harry retorna para seu quarto ano na Escola de Magia e Bruxaria de Hogwarts, junto com os seus amigos Ron e Hermione. Desta vez, acontece um torneio entre as três maiores escola de magia, com um participante selecionado de cada escola, pelo Cálice de Fogo. O nome de Harry aparece, mesmo não tendo se inscrito, e ele precisa competir.'
      },
    ],
    'Mais assistidos': [
      {
        'title': 'Velozes e Furiosos 8',
        'genre': 'Ação, Aventura e Crime',
        'imageUrl':
            'https://i0.statig.com.br/bancodeimagens/c0/ql/wl/c0qlwl4vwfwebs2dubrqb5qpa.jpg',
        'rating': 4.5,
        'duration': '2h 16min',
      },
    ]
  };

  // Método para adicionar um novo filme a uma categoria específica
  void addMovie(String category, Map<String, dynamic> movie) {
    if (movieCategories.containsKey(category)) {
      movieCategories[category]!.add(movie);
    } else {
      movieCategories[category] = [movie];
    }
  }

  // Método para remover um filme
  void removeMovie(String category, Map<String, dynamic> movie) {
    movieCategories[category]?.removeWhere((item) => item['title'] == movie['title']);
  }
}

