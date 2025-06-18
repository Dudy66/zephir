import 'package:zephir/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // pour afficher correctement les dates et heures en français

void main() {
  runApp(const Zephir());
}

class Zephir extends StatelessWidget {
  const Zephir({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenue sur Zéphir',
      debugShowCheckedModeBanner: false,
      locale: const Locale(
        'fr',
        'FR',
      ), // je force le français comme langue par défaut
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomePage(), // je lance ma page d’accueil
    );
  }
}
