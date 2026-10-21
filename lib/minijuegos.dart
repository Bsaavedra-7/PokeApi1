import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/main_screen/widgets/poke_logo.dart';
import 'package:proyecto_poke_api/pag_pokedex.dart';
import 'package:proyecto_poke_api/HolScreen/higher_or_lower_game.dart';
import 'package:proyecto_poke_api/SiluetaScreen/silueta.dart';

void main() {
  runApp(const MinijuegosApp());
}

class MinijuegoItem {
  final String titulo;
  final IconData icono;
  final Color color;
  final Widget destino; // la pagina/ juego

  const MinijuegoItem({
    required this.titulo,
    required this.icono,
    required this.color,
    required this.destino,
  });
}

class MinijuegoCard extends StatelessWidget {
  final MinijuegoItem item;
  const MinijuegoCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => item.destino),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [//aca creo el card para cada minijuego con la info de la class miinijuegos
            Icon(item.icono, size: 48, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              item.titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class MinijuegosApp extends StatelessWidget {
  const MinijuegosApp({super.key});

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


//aca se crean o se almacenan los minijuegos, luego se pueden agregar mas.
  final List<MinijuegoItem> minijuegos = const [
    MinijuegoItem(
      titulo: 'Higher or Lower',
      icono: Icons.sports_esports,
      color: Colors.blue,
      destino: HigherOrLowerApp(),
    ),
    MinijuegoItem(
      titulo: '¿How is That Pokémon?',
      icono: Icons.videogame_asset,
      color: Colors.green,
      destino: SiluetaApp(),
    ),
    // agregar luego otros minujuegos aca
  ];

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
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (e) => const MainPokedex()),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF243256)),
              child: Text('Menu'),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFF131526),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: minijuegos
                .map(//el calsico map que devuelve todos los minijuegos
                  (item) =>
                      SizedBox(width: 180, child: MinijuegoCard(item: item)),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
