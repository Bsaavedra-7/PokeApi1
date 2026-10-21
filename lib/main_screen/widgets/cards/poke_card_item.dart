import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/data/model/pokedex_response.dart';

//esta clase es para mostrar una tarjeta de pokémon en singular, 
//con su información y sprite, se usa dentro de PokeCard para mostrar
//cada pokémon individualmente
class PokeCardItem extends StatelessWidget {
  final PokedexResponse pokemon;
  final void Function()? onTap;

  const PokeCardItem({
    super.key,
    required this.pokemon,
    this.onTap,
  });

  // Renderiza el sprite o un ícono de reemplazo si el
  // sprite está vacío o falla al cargar.
  Widget _buildSprite(String spriteUrl) {
    if (spriteUrl.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Icon(
          Icons.help_outline_rounded,
          size: 120,
          color: Colors.white54,
        ),
      );
    }
    //Renderiza el sprite desde la URL
    return Image.network(
      spriteUrl,
      scale: 0.8,
      errorBuilder: (context, error, stackTrace) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Icon(
            Icons.help_outline_rounded,
            size: 120,
            color: Color(0x8DFFFFFF),
          ),
        );
      },
    );
  }

  // Renderiza la tarjeta del Pokémon con su información y sprite.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF396CAF),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "N° de Pokédex: ${pokemon.id}",
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFF9F9F9),
              ),
            ),
            Text(
              "Nombre: ${pokemon.nombre}",
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFF9F9F9),
              ),
            ),
            Text(
              "Tipos: ${pokemon.tipos.join(", ")}",
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFF9F9F9),
              ),
            ),
            Expanded(
              child: _buildSprite(pokemon.sprite),
            ),
          ],
        ),
      ),
    );
  }
}