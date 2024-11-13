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
        'duration': '2h 16min',
      },
      {
        'title': 'Harry Potter e o Cálice de Fogo',
        'genre': 'Aventura, Fantasia',
        'imageUrl':
            'https://i0.wp.com/villarica.com.br/wp-content/uploads/2022/09/HARRY-POTTER-E-O-CA%CC%81LICE-DE-FOGO-.webp?fit=1000%2C1500&ssl=1',
        'rating': 4.0,
        'duration': '2h 37min',
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
}
