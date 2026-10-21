import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/main_screen/poke_controller.dart';
import 'package:proyecto_poke_api/main_screen/widgets/buscador/icono_buscador.dart';

// Componente visual reutilizable para el campo de entrada de la búsqueda.
// Encapsula el diseño del TextField y establece el punto de referencia para el desplegable flotante.
class PokeSearchBar extends StatelessWidget {
  final PokedexController controller;
  final LayerLink layerLink;

  const PokeSearchBar({
    super.key,
    required this.controller,
    required this.layerLink,
  });

  @override
  Widget build(BuildContext context) {
    // Actúa como el ancla visual (target) asociada al LayerLink para sincronizar
    // la ubicación del menú desplegable con la posición exacta de este widget.
    return CompositedTransformTarget(
      link: layerLink,
      child: TextField(
        style: const TextStyle(color: Color(0xFFFFFFFF)),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          hintText: "Buscar pokémon...",
          prefixIcon: iconoBuscador(),
          filled: true,
          fillColor: const Color(0xFF3C5289),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF64D0FF),
              width: 2,
            ),
          ),
          hintStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            color: Color(0xFFCEEAED),
          ),
        ),
        // Notifica al controlador en cada pulsación de tecla para filtrar las sugerencias en tiempo real.
        onChanged: controller.filterSuggestions,
      ),
    );
  }
}