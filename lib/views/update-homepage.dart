import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UpdateHomePage extends StatelessWidget {
  final Map<String, dynamic> movie;
  final void Function(Map<String, dynamic>) onSave;

  UpdateHomePage({super.key, required this.movie, required this.onSave});

  final _titleController = TextEditingController();
  final _genreController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _durationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yearController = TextEditingController();
  double _score = 0.0;  // Variável para armazenar a pontuação
  String? _ageRating;

  @override
  Widget build(BuildContext context) {
    // Inicializando os campos com os valores do filme
    _titleController.text = movie['title'] ?? '';
    _genreController.text = movie['genre'] ?? '';
    _imageUrlController.text = movie['imageUrl'] ?? '';
    _durationController.text = movie['duration'] ?? '';
    _descriptionController.text = movie['description'] ?? '';
    _yearController.text = movie['ano'] ?? '';
    _ageRating = movie['ageRating'] ?? 'Livre';
    _score = movie['rating'] ?? 0.0;  // Inicializando a pontuação com o valor do filme

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Filme", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _genreController,
                decoration: const InputDecoration(labelText: 'Gênero'),
              ),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL da Imagem'),
              ),
              TextField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Duração'),
              ),
              TextField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Ano'),
              ),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _ageRating,
                decoration: const InputDecoration(labelText: 'Classificação Etária'),
                items: [
                  'Livre',
                  '10',
                  '12',
                  '14',
                  '16',
                  '18',
                ].map((rating) {
                  return DropdownMenuItem<String>(
                    value: rating,
                    child: Text(rating),
                  );
                }).toList(),
                onChanged: (value) {
                  _ageRating = value;
                },
              ),
              const SizedBox(height: 20),
              // Adicionando o RatingBar
              RatingBar.builder(
                initialRating: _score,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30.0,
                itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  _score = rating;  // Atualiza a pontuação ao mudar a avaliação
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Atualiza os dados e retorna para a tela principal
                  onSave({
                    'title': _titleController.text,
                    'genre': _genreController.text,
                    'imageUrl': _imageUrlController.text,
                    'duration': _durationController.text,
                    'description': _descriptionController.text,
                    'ano': _yearController.text,
                    'ageRating': _ageRating,
                    'rating': _score,  // Salva a pontuação também
                  });
                  Navigator.pop(context);
                },
                child: const Text("Salvar Alterações", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
