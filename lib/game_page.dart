import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/escuro.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'Que comecem os jogos !',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(
                  color: Colors.white), // Define a cor da seta de voltar
            ),
            body: const Center(
              child: Text(
                'Bem-vindo ao jogo!',
                style: TextStyle(
                    color: Colors.white), // Define a cor do texto no corpo
              ),
            ),
          ),
        ],
      ),
    );
  }
}
