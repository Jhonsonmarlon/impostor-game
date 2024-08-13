import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Título da Página 1",
          body: "Descrição da Página 1",
          image: Image.asset('assets/imagem1.png', width: 327, height: 232),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Título da Página 2",
          body: "Descrição da Página 2",
          image: Image.asset('assets/imagem2.png', width: 327, height: 232),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Título da Página 3",
          body: "Descrição da Página 3",
          image: Image.asset('assets/imagem3.png', width: 327, height: 232),
          decoration: getPageDecoration(),
          footer: ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('hasSeenOnboarding', true);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6E23),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            ),
            child: const Text(
              'Vamos Jogar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
      showNextButton: true,
      showSkipButton: true,
      skip: const Text('Pular', style: TextStyle(color: Colors.white)),
      next: const Icon(Icons.arrow_forward, color: Colors.white),
      done: const Text('Próximo', style: TextStyle(color: Colors.white)),
      onDone: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('hasSeenOnboarding', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      dotsDecorator: DotsDecorator(
        color: Colors.white.withOpacity(0.5),
        activeColor: Colors.white,
        size: const Size(10.0, 10.0),
        activeSize: const Size(15.0, 10.0),
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
      ),
      globalBackgroundColor: const Color(0xFF1F2228),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFF6E23),
      ),
      bodyTextStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.white,
      ),
      imagePadding: EdgeInsets.all(0),
      pageColor: Color(0xFF1F2228),
    );
  }
}
