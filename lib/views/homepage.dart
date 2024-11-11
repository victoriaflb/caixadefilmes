import 'package:flutter/material.dart';

// Visualização do Usuário no App
class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Elsabox - Filmes",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Conteúdo Principal",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
            ],
          ),
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
    );
  }
}
