import 'package:flutter/material.dart';
import 'package:impostor/bottom_navigation_bar_widget.dart';
import 'package:impostor/drawer_widget.dart';

void main() {
  runApp(const MyApp());
}

enum SelectedTab { home, novoJogo, biblioteca }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Impostor Game',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedTab = SelectedTab.home;
  bool _showNewGameCard = false;
  bool _showLibraryCard = false;
  int _participants = 2;

  void _handleIndexChanged(int i) {
    final newTab = SelectedTab.values[i];

    setState(() {
      if (newTab != _selectedTab) {
        _selectedTab = newTab;
        _showNewGameCard = (newTab == SelectedTab.novoJogo);
        _showLibraryCard = (newTab == SelectedTab.biblioteca);
      } else {
        if (newTab == SelectedTab.home) {
          _showNewGameCard = false;
          _showLibraryCard = false;
        } else if (newTab == SelectedTab.biblioteca) {
          _showNewGameCard = false;
          _showLibraryCard = true;
        }
      }
    });
  }

  void _startGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoadingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/wolf.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text(
                'Impostor Game',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 219, 11, 11),
                ),
              ),
              backgroundColor: const Color.fromARGB(0, 143, 19, 19),
              elevation: 0,
              centerTitle: true,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  color: const Color.fromARGB(255, 212, 0, 0),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
            drawer: const DrawerWidget(),
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_showNewGameCard)
                        Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Quantos participantes?',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Slider(
                                  value: _participants.toDouble(),
                                  min: 2,
                                  max: 10,
                                  divisions: 8,
                                  label: _participants.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      _participants = value.toInt();
                                    });
                                  },
                                ),
                                Text(
                                  'Número de participantes: $_participants',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Haverá ${_participants <= 6 ? '1 impostor' : '2 impostores'}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ),
                                ElevatedButton(
                                  onPressed: () => _startGame(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  child: const Text('Começar'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (_showLibraryCard)
                        const Card(
                          elevation: 4,
                          margin: EdgeInsets.all(16.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Biblioteca de Desenhos',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBarWidget(
              selectedTab: _selectedTab,
              onTap: _handleIndexChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GamePage(),
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: Image.asset('assets/countdown.gif'),
      ),
    );
  }
}

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo'),
        backgroundColor: const Color.fromARGB(255, 231, 15, 15),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/escuro.png'),
            fit: BoxFit.cover,
          ),
        ),
        // Conteúdo do jogo aqui
      ),
    );
  }
}
