import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Usando o flutter_rating_bar
import 'package:caixadefilmes/controller/createmovies.dart'; // Certifique-se de ajustar o caminho conforme seu projeto

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _idController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _genreController = TextEditingController();
  final _ageRatingController = TextEditingController();
  final _durationController = TextEditingController();
  final _scoreController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yearController = TextEditingController();

  String? _selectedAgeRating = 'Livre'; // Faixa etária selecionada
  double _score = 0.0; // Pontuação do filme

  final Map<String, List<Map<String, dynamic>>> movieCategories = {
    'Em Alta': [
      {
        'title': 'Velozes e Furiosos 8',
        'genre': 'Ação, Aventura e Crime',
        'imageUrl': 'https://link-para-imagem.com/velozes_furiosos.jpg',
        'rating': 4.5,
        'duration': '2h 16min',
      },
      {
        'title': 'Harry Potter e o Cálice de Fogo',
        'genre': 'Aventura, Fantasia',
        'imageUrl': 'https://link-para-imagem.com/harry_potter.jpg',
        'rating': 4.0,
        'duration': '2h 37min',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: movieCategories.length, vsync: this);
  }

  // Método para submeter o formulário
  void _submitForm() {
    // Adiciona o filme à categoria "Em Alta" (pode ser alterado conforme necessário)
    setState(() {
      movieCategories['Em Alta']!.add({
        'title': _titleController.text,
        'genre': _genreController.text,
        'imageUrl': _imageUrlController.text,
        'rating': _score,
        'duration': _durationController.text,
      });
    });

    // Limpa os campos do formulário após o envio
    _idController.clear();
    _imageUrlController.clear();
    _titleController.clear();
    _genreController.clear();
    _ageRatingController.clear();
    _durationController.clear();
    _scoreController.clear();
    _descriptionController.clear();
    _yearController.clear();

    // Exibe um diálogo de sucesso
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sucesso"),
          content: Text("Filme cadastrado com sucesso!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o alerta
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: movieCategories.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Filmes",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Grupo"),
                      content: Text("Nome do grupo: CaixadeFilmes"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: movieCategories.keys.map((String category) {
                return Tab(text: category);
              }).toList(),
              indicatorColor: Colors.white,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: movieCategories.keys.map((String category) {
              List<Map<String, dynamic>> movies = movieCategories[category]!;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    var movie = movies[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: Image.network(
                          movie['imageUrl'],
                          width: 50,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          movie['title'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${movie['genre']} - ${movie['duration']}',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 8),
                            RatingBar.builder(
                              initialRating: movie['rating'],
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20.0,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print('Pontuação: $rating');
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: _titleController,
                              decoration: InputDecoration(labelText: 'Título'),
                            ),
                            TextField(
                              controller: _imageUrlController,
                              decoration:
                                  InputDecoration(labelText: 'URL da Imagem'),
                            ),
                            TextField(
                              controller: _genreController,
                              decoration: InputDecoration(labelText: 'Gênero'),
                            ),
                            TextField(
                              controller: _durationController,
                              decoration: InputDecoration(labelText: 'Duração'),
                            ),
                            DropdownButton<String>(
                              value: _selectedAgeRating,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedAgeRating = newValue!;
                                });
                              },
                              items: <String>[
                                'Livre',
                                '10',
                                '12',
                                '14',
                                '16',
                                '18'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 10),
                            RatingBar.builder(
                              initialRating: _score,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 30.0,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  _score = rating;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _descriptionController,
                              maxLines: 5,
                              decoration:
                                  InputDecoration(labelText: 'Descrição'),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _submitForm,
                              child: Text('Cadastrar Filme'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _idController.dispose();
    _imageUrlController.dispose();
    _titleController.dispose();
    _genreController.dispose();
    _ageRatingController.dispose();
    _durationController.dispose();
    _scoreController.dispose();
    _descriptionController.dispose();
    _yearController.dispose();
    super.dispose();
  }
}
