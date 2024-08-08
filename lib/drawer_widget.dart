import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
      child: Column(
        children: [
          const SizedBox(height: 16), // Espaço acima
          const CircleAvatar(
            backgroundImage: AssetImage('assets/jj.png'),
            radius: 60, // Tamanho da foto
          ),
          const SizedBox(height: 8), // Espaço entre a foto e o nome
          const Text(
            'JJ Developer',
            style: TextStyle(
              color: Color.fromARGB(255, 235, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(), // Empurra o conteúdo para baixo
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Versão 1.0.4',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram),
                color: Colors.white, // Cor do ícone Instagram
                onPressed: () {
                  _launchURL(
                      'https://www.instagram.com/console.jj/?utm_source=ig_web_button_share_sheet');
                },
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.tiktok),
                color: Colors.white, // Cor do ícone TikTok
                onPressed: () {
                  _launchURL(
                      'https://www.tiktok.com/@console.jj?_t=8od9GI4CccQ&_r=1');
                },
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.github),
                color: Colors.white, // Cor do ícone GitHub
                onPressed: () {
                  _launchURL('https://github.com/jhonsonmarlon');
                },
              ),
            ],
          ),
          const SizedBox(height: 16), // Espaço abaixo
        ],
      ),
    );
  }
}
