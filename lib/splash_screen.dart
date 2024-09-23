import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:impostor/onboarding_screen.dart'; // Certifique-se de ajustar o caminho
import 'package:impostor/main.dart'; // Certifique-se de ajustar o caminho

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    await Future.delayed(const Duration(seconds: 6)); // Atraso de 3 segundos
    final prefs = await SharedPreferences.getInstance();
    final isOnboardingCompleted =
        prefs.getBool('isOnboardingCompleted') ?? false;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            isOnboardingCompleted ? const HomePage() : OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/fundo2.png'), // Sua imagem de splash screen
      ),
    );
  }
}
