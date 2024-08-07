import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _currentStep = 1;  // To track the current step in the game setup
  int _participants = 3;  // Number of participants
  List<String> _participantNames = [];  // List to store participant names
  String _selectedCategory = '';  // Selected category for the game
  List<String> _categories = ['Animais', 'Objetos'];  // Example categories
  String _currentPlayer = '';  // Name of the current player
  String _role = '';  // Role of the current player
  String _drawingTask = '';  // Drawing task for the drawer

  void _updateParticipants(double value) {
    setState(() {
      _participants = value.toInt();
    });
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _setParticipantName(int index, String name) {
    setState(() {
      if (index >= _participantNames.length) {
        _participantNames.add(name);
      } else {
        _participantNames[index] = name;
      }
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _startGame() {
    setState(() {
      // Logic to start the game
      _currentPlayer = _participantNames[0];  // Example: select the first player
      _role = 'Impostor';  // Example: assign a role
      _drawingTask = 'Cachorro';  // Example: assign a drawing task
    });
  }

  void _showResult() {
    setState(() {
      // Logic to show the result of the draw
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Jogando ...',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 219, 11, 11),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 219, 11, 11)),
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
        child: Center(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildStepContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildParticipantSelection();
      case 2:
        return _buildNameInputs();
      case 3:
        return _buildCategorySelection();
      case 4:
        return _buildCountdown();
      case 5:
        return _buildDrawRole();
      default:
        return const Text('Erro: Etapa desconhecida');
    }
  }

  Widget _buildParticipantSelection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Quantos participantes?',
          style: TextStyle(fontSize: 18),
        ),
        Slider(
          value: _participants.toDouble(),
          min: 3,
          max: 10,
          divisions: 8,
          label: _participants.toString(),
          onChanged: _updateParticipants,
        ),
        Text(
          'Número de participantes: $_participants',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Haverá ${_participants <= 6 ? '1 impostor' : '2 impostores'}',
          style: const TextStyle(fontSize: 16, color: Colors.red),
        ),
        ElevatedButton(
          onPressed: _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('Próximo'),
        ),
      ],
    );
  }

  Widget _buildNameInputs() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Insira os nomes dos participantes',
          style: TextStyle(fontSize: 18),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _participants,
          itemBuilder: (context, index) {
            return TextField(
              decoration: InputDecoration(
                labelText: 'Participante ${index + 1}',
              ),
              onChanged: (value) {
                _setParticipantName(index, value);
              },
            );
          },
        ),
        ElevatedButton(
          onPressed: _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('Próximo'),
        ),
      ],
    );
  }

  Widget _buildCategorySelection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Selecione uma categoria',
          style: TextStyle(fontSize: 18),
        ),
        Wrap(
          spacing: 10.0,
          children: _categories.map((category) {
            return ChoiceChip(
              label: Text(category),
              selected: _selectedCategory == category,
              onSelected: (selected) {
                _selectCategory(category);
              },
            );
          }).toList(),
        ),
        ElevatedButton(
          onPressed: () {
            _nextStep();
            _startGame();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('Começar'),
        ),
      ],
    );
  }

  Widget _buildCountdown() {
    // Placeholder for countdown logic
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Contagem regressiva...',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('Próximo'),
        ),
      ],
    );
  }

  Widget _buildDrawRole() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Jogador atual: $_currentPlayer',
          style: const TextStyle(fontSize: 18),
        ),
        ElevatedButton(
          onPressed: _showResult,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('Sortear'),
        ),
        if (_role.isNotEmpty)
          Column(
            children: [
              Text(
                'Você é $_role',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
              if (_role == 'Desenhista')
                Text(
                  'Desenhe: $_drawingTask',
                  style: const TextStyle(fontSize: 16),
                ),
              ElevatedButton(
                onPressed: () {
                  // Logic to proceed with the game
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Iniciar Jogo'),
              ),
            ],
          ),
      ],
    );
  }
}
