import 'package:flutter/material.dart';

// Visualização do Usuário no App
class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  // Controlador para o TabBar
  late TabController _tabController;

  // Exemplo de categorias e filmes
  final Map<String, List<String>> movieCategories = {
    'Em Alta': ['Filme', 'Filme', 'Filme'],
    'Ação': ['Filme', 'Filme', 'Filme'],
    'Comédia': ['Filme', 'Filme', 'Filme'],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: movieCategories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: movieCategories.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Elsabox - Filmes",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
            bottom: TabBar(
              controller: _tabController,
              tabs: movieCategories.keys.map((String category) {
                return Tab(text: category);
              }).toList(),
              indicatorColor: Colors.white,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Grupo: "),
                        content: Text(
                          "\nCamila Rolim\nMaria Victória\nEdyllauson Alves",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: movieCategories.keys.map((String category) {
              List<String> movies = movieCategories[category]!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    String movie = movies[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: Icon(Icons.movie, size: 50),
                        title: Text(
                          movie,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Descrição do filme'),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
          floatingActionButton: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(), // Define o formato circular
              padding: EdgeInsets.all(20), // Define o tamanho do círculo
              backgroundColor: Colors.black, // Cor de fundo
            ),
            onPressed: () {
              // Ação para o botão adicionar
            },
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
