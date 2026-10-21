import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/main_screen/poke_controller.dart';
import 'package:proyecto_poke_api/main_screen/widgets/poke_logo.dart';
import 'package:proyecto_poke_api/main_screen/widgets/buscador/poke_buscador.dart';
import '../minijuegos.dart';
class PokeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PokedexController controller;
  final LayerLink layerLink;

  const PokeAppBar({
    super.key,
    required this.controller,
    required this.layerLink,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: const Color(0xFF243256),
      foregroundColor: Colors.white,
      automaticallyImplyLeading: false,
      titleSpacing: 24,
      title: Row(
        children: [
          const SizedBox(width: 250, child: PokeLogo()),
          const SizedBox(width: 24),
          SizedBox(
            width: 450,
            child: PokeSearchBar(controller: controller, layerLink: layerLink),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.sports_esports, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MinijuegosApp()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
