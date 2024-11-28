import 'package:caixadefilmes/views/update-homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:caixadefilmes/controller/createmovies.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _controller = CreateMoviesController();

  final _idController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _genreController = TextEditingController();
  final _ageRatingController = TextEditingController();
  final _durationController = TextEditingController();
  final _scoreController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yearController = TextEditingController();

String? _selectedAgeRating = "Livre";
  double _score = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _controller.movieCategories.length, vsync: this);
  }

  // Método para submeter o formulário
  void _submitForm() {
    if (_titleController.text.isEmpty || _imageUrlController.text.isEmpty || _genreController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Preencha todos os campos obrigatórios!"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      _controller.addMovie('Em Alta', {
        'title': _titleController.text,
        'genre': _genreController.text,
        'imageUrl': _imageUrlController.text,
        'rating': _score,
        'duration': _durationController.text,
        'description': _descriptionController.text,
        'ageRating': _selectedAgeRating,
        'ano': _yearController.text
      });
    });

    // Limpar os campos
    _idController.clear();
    _imageUrlController.clear();
    _titleController.clear();
    _genreController.clear();
    _ageRatingController.clear();
    _durationController.clear();
    _scoreController.clear();
    _descriptionController.clear();
    _yearController.clear();

    // Mostrar mensagem de sucesso
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sucesso"),
          content: Text("Filme cadastrado com sucesso!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Exibir os detalhes do filme
  void _exibirDetalhes(BuildContext context, Map<String, dynamic> movie) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              movie['title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagem do filme
                if (movie['imageUrl'] != null && movie['imageUrl'].isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      movie['imageUrl'],
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                else
                  Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey.shade700,
                        size: 60,
                      ),
                    ),
                  ),
                SizedBox(height: 20),

                // Gênero e duração
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gênero: ${movie['genre']}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Duração: ${movie['duration']}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Classificação etária
                Text(
                  "Classificação: ${movie['ageRating'] ?? 'Livre'}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),

                // Ano
                Text(
                  "Ano: ${movie['ano']}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),

                // Descrição
                Text(
                  movie['description'] ?? "Sem descrição disponível.",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Fechar"),
              ),
            ),
          ],
        );
      },
    );
  }


  void _editarFilme(BuildContext context, Map<String, dynamic> movie, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateHomePage(
          movie: movie,
          onSave: (updatedMovie) {
            setState(() {
              int index = _controller.movieCategories[category]!.indexOf(movie);
              _controller.movieCategories[category]![index] = {
                ...movie,
                ...updatedMovie,
              };
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: _controller.movieCategories.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Filmes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                icon: Icon(Icons.info, color: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      title: Text("Grupo"),
                      content: Text("Camila Rolim\nMaria Victória\nEdyllauson Alves", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
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
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: _controller.movieCategories.keys.map((String category) {
                return Tab(text: category);
              }).toList(),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: _controller.movieCategories.keys.map((String category) {
              List<Map<String, dynamic>> movies = _controller.movieCategories[category]!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    var movie = movies[index];
                    return Dismissible(
                      key: Key(movie['title']),
                      background: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          _controller.removeMovie(category, movie);
                        });
                      },
                      direction: DismissDirection.endToStart,
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                                child: Image.network(movie['imageUrl'], fit: BoxFit.cover),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(12.0),
                              title: Text(
                                movie['title'],
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: "details",
                                    child: const Text("Ver detalhes"),
                                  ),
                                  PopupMenuItem(
                                    value: "edit",
                                    child: const Text("Editar"),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == "details") {
                                    _exibirDetalhes(context, movie); // Exibe detalhes
                                  } else if (value == "edit") {
                                    _editarFilme(context, movie, category); // Edita o filme
                                  }
                                },
                              ),
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
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              decoration: InputDecoration(labelText: 'URL da Imagem'),
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
                            TextField(
                              controller: _yearController,
                              decoration: InputDecoration(labelText: 'Ano'),
                            ),
                            TextField(
                              controller: _descriptionController,
                              maxLines: 5,
                              decoration: InputDecoration(labelText: 'Descrição'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Avaliação",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            RatingBar.builder(
                              initialRating: _score,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 30.0,
                              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  _score = rating;
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _submitForm,
                              child: Text("Cadastrar Filme"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )
          ),
        ),
      ),
    );
  }
}
