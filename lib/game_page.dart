import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Categoria {
  final String nome;
  final IconData icone;
  final List<String> palavras;

  Categoria({required this.nome, required this.icone, required this.palavras});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      nome: json['nome'],
      icone: _getIconData(json['icone']),
      palavras: List<String>.from(json['palavras']),
    );
  }

  static IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'Icons.pets':
        return Icons.pets;
      case 'Icons.work':
        return Icons.work;
      case 'Icons.fastfood':
        return Icons.fastfood;
      case 'Icons.directions_car':
        return Icons.directions_car;
      case 'Icons.nature':
        return Icons.nature;
      case 'Icons.sports_soccer':
        return Icons.sports_soccer;
      case 'Icons.shopping_bag':
        return Icons.shopping_bag;
      case 'Icons.build':
        return Icons.build;
      case 'Icons.computer':
        return Icons.computer;
      default:
        return Icons.help;
    }
  }
}

Future<List<Categoria>> _loadCategorias() async {
  final String response =
      await rootBundle.loadString('assets/database/palavras.json');
  final data = await json.decode(response);
  return (data['categorias'] as List)
      .map((i) => Categoria.fromJson(i))
      .toList();
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _currentStep = 0;
  int quantidadeParticipantes = 3;
  List<String> nomesParticipantes = List.filled(3, '');
  List<TextEditingController> nomeControllers = [];
  String categoriaSelecionada = '';
  List<Categoria> categorias = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategorias().then((cats) {
      setState(() {
        categorias = cats;
        isLoading = false;
      });
    });
    _initNomeControllers(quantidadeParticipantes);
  }

  void _initNomeControllers(int quantidade) {
    nomeControllers = List.generate(
      quantidade,
      (index) => TextEditingController(text: nomesParticipantes[index]),
    );
  }

  @override
  void dispose() {
    for (var controller in nomeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogando'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 231, 32, 18)),
          onPressed: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep--;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0) {
            setState(() {
              _currentStep++;
            });
          } else if (_currentStep == 1 &&
              !nomesParticipantes.any((nome) => nome.isEmpty)) {
            setState(() {
              _currentStep++;
            });
          } else if (_currentStep == 2 && categoriaSelecionada.isNotEmpty) {
            setState(() {
              _currentStep++;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Preencha todos os campos!')),
            );
          }
        },
        onStepCancel: _currentStep > 0
            ? () {
                setState(() {
                  _currentStep--;
                });
              }
            : null,
        steps: [
          Step(
            title: const Text('Quantos participantes?'),
            content: Column(
              children: [
                Slider(
                  value: quantidadeParticipantes.toDouble(),
                  min: 3,
                  max: 10,
                  divisions: 7,
                  label: quantidadeParticipantes.toString(),
                  onChanged: (value) {
                    setState(() {
                      quantidadeParticipantes = value.toInt();
                      nomesParticipantes =
                          List.filled(quantidadeParticipantes, '');
                      _initNomeControllers(quantidadeParticipantes);
                    });
                  },
                ),
                Text('$quantidadeParticipantes Participantes'),
                const SizedBox(height: 20),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Nomes dos Participantes'),
            content: Column(
              children: List.generate(quantidadeParticipantes, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: nomeControllers[index],
                    onChanged: (value) {
                      setState(() {
                        nomesParticipantes[index] = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Nome do Participante ${index + 1}'),
                  ),
                );
              }),
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Selecione uma Categoria'),
            content: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: categorias.map((categoria) {
                      return ChoiceChip(
                        label: Text(categoria.nome),
                        avatar: Icon(categoria.icone),
                        selected: categoriaSelecionada == categoria.nome,
                        onSelected: (selected) {
                          setState(() {
                            categoriaSelecionada = categoria.nome;
                          });
                        },
                      );
                    }).toList(),
                  ),
            isActive: _currentStep >= 2,
          ),
          Step(
            title: const Text('Iniciar Jogo'),
            content: Column(
              children: [
                Text('Participantes: $quantidadeParticipantes'),
                const SizedBox(height: 20),
                Text('Categoria: $categoriaSelecionada'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para iniciar o jogo
                  },
                  child: const Text('Começar'),
                ),
              ],
            ),
            isActive: _currentStep >= 3,
          ),
        ],
      ),
    );
  }
}
