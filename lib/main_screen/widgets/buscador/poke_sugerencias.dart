import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/main_screen/poke_controller.dart';

// Componente encargado de renderizar la lista flotante de sugerencias,
// posicionada dinámicamente según la ubicación del campo de búsqueda mediante LayerLink.
class PokeSuggestionsDropdown extends StatelessWidget {
  final PokedexController controller;
  final LayerLink layerLink;

  const PokeSuggestionsDropdown({
    super.key,
    required this.controller,
    required this.layerLink,
  });

  @override
  Widget build(BuildContext context) {
    // Sigue automáticamente al CompositedTransformTarget del buscador sin recortarse por la AppBar.
    return CompositedTransformFollower(
      link: layerLink,
      showWhenUnlinked: false,
      targetAnchor: Alignment.bottomLeft,
      followerAnchor: Alignment.topLeft,
      child: SizedBox(
        width: 450,
        // El widget Material provee el lienzo necesario para los efectos táctiles y estilos del ListTile.
        child: Material(
          color: const Color(0xFF3C5289),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.sugerencias.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    controller.sugerencias[index],
                    style: const TextStyle(color: Color(0xFFCEEAED)),
                  ),
                  onTap: () {
                    controller.selectPokemon(
                      controller.sugerencias[index],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}