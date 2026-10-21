import 'package:flutter/material.dart';

//esta clase es para mostrar un toggle de sprite
//en la pantalla de detalles del Pokémon
class SpriteToggle extends StatelessWidget {
  final String spriteNormal;
  final String spriteShiny;
  final bool mostrarShiny;
  //esta funcion se ejecuta cuando se toca el toggle
  //se pasa desde pag_detalles.dart para que este pueda
  //cambiar el estado de mostrarShiny
  final void Function() onToggle;

  const SpriteToggle({
    super.key,
    required this.spriteNormal,
    required this.spriteShiny,
    required this.mostrarShiny,
    required this.onToggle,
  });
  //este Widget crea un chip que se puede tocar y
  //representa el estado de mostrarShiny, si es true se muestra el chip activo
  //y si es false se muestra el chip inactivo
  Widget _chip(String label, bool activo, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: activo ? const Color(0xFF396CAF) : const Color(0xFF243256),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: activo ? const Color(0xFF64D0FF) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: activo ? Colors.white : Colors.white54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spriteActual = mostrarShiny ? spriteShiny : spriteNormal;

    return Column(
      children: [
        // Tocar la imagen igual alterna entre sprites
        GestureDetector(
          onTap: onToggle,
          child: SizedBox(
            height: 275,
            child: spriteActual.isEmpty
                //por si la API no entrega un sprite porque no existe
                //o no tienen versión shiny
                ? const Icon(
                    Icons.help_outline_rounded,
                    size: 120,
                    color: Colors.white54,
                  )
                : Image.network(
                    filterQuality: FilterQuality.high, //se supone mejora la calidad de la imagen
                    spriteActual,
                    fit: BoxFit.contain,
                    //por si la imagen no carga por algun motivo
                    //sin internet, no sirve la url, se cayó la api, etc.
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.help_outline_rounded,
                      size: 120,
                      color: Colors.white54,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        //aqui van los chips para alternar entre sprite normal y shiny
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _chip("Normal", !mostrarShiny, () {
              if (mostrarShiny) onToggle();
            }),
            const SizedBox(width: 12),
            _chip("Shiny", mostrarShiny, () {
              if (!mostrarShiny) onToggle();
            }),
          ],
        ),
      ],
    );
  }
}
