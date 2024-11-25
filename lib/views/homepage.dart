import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:caixadefilmes/controller/createmovies.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
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

  String? _selectedAgeRating = 'Livre';
  double _score = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _controller.movieCategories.length, vsync: this);
  }

  // Método para submeter o formulário
  void _submitForm() {
    setState(() {
      _controller.addMovie('Em Alta', {
        'title': _titleController.text,
        'genre': _genreController.text,
        'imageUrl': _imageUrlController.text,
        'rating': _score,
        'duration': _durationController.text,
      });
    });

    _idController.clear();
    _imageUrlController.clear();
    _titleController.clear();
    _genreController.clear();
    _ageRatingController.clear();
    _durationController.clear();
    _scoreController.clear();
    _descriptionController.clear();
    _yearController.clear();

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
                Icon(Icons.info, color: Colors.white);
                Navigator.pop(context);
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
        length: _controller.movieCategories.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Filmes",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
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
              List<Map<String, dynamic>> movies =
                  _controller.movieCategories[category]!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    var movie = movies[index];
                    // Function Delete
                    return Dismissible(
                      key:
                          Key(movie['title']),
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
                          movies.removeAt(
                              index);
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
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(4.0)),
                                child: Image.network(
                                  movie['imageUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(12.0),
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
                                      style: TextStyle(fontSize: 14)),
                                  SizedBox(height: 8),
                                  RatingBar.builder(
                                    initialRating: movie['rating'],
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    itemBuilder: (context, index) =>
                                        Icon(Icons.star, color: Colors.amber),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ],
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
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextField(
                                controller: _titleController,
                                decoration:
                                    InputDecoration(labelText: 'Título')),
                            TextField(
                                controller: _imageUrlController,
                                decoration: InputDecoration(
                                    labelText: 'URL da Imagem')),
                            TextField(
                                controller: _genreController,
                                decoration:
                                    InputDecoration(labelText: 'Gênero')),
                            TextField(
                                controller: _durationController,
                                decoration:
                                    InputDecoration(labelText: 'Duração')),
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
