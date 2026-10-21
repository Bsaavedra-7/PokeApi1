import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/main_screen/widgets/poke_logo.dart';
import '../minijuegos.dart';//para crear un icon que dijira a aca.

void main() {
  runApp(const SiluetaApp());
}

class SiluetaApp extends StatelessWidget {
  const SiluetaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(Colors.grey),
          thickness: WidgetStateProperty.all(8),
          radius: const Radius.circular(10),
        ),
      ),
      home: const MinijuegosScreen(),
    );
  }
}

class MinijuegosScreen extends StatelessWidget {
  const MinijuegosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF243256),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        titleSpacing: 24,
        title: const SizedBox(width: 250, child: PokeLogo()),
        actions: [
          IconButton(
            icon: const Icon(Icons.sports_esports, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (e) => const MinijuegosApp()),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF131526),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}