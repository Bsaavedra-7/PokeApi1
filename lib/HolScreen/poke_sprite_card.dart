import 'package:flutter/material.dart';

class PokeSpriteCard extends StatefulWidget {
  final int id;
  final String nombre;
  final String sprite;
  final VoidCallback? onTap;
  final bool isSelected; // Controlado desde padre

  const PokeSpriteCard({
    super.key,
    required this.id,
    required this.nombre,
    required this.sprite,
    this.onTap,
    this.isSelected = false,
  });

  @override
  State<PokeSpriteCard> createState() => _PokeSpriteCardState();
}

class _PokeSpriteCardState extends State<PokeSpriteCard> {

  @override
  Widget build(BuildContext context) {
    final baseColor = const Color(0xFF396CAF);
    final selectedColor = const Color(0xFFFF9800); // color al seleccionar opcion


// el widget GestureDetector me permite detectar el click del usuario y cambiar el color de la card
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        width: 200,
        height: 280,
        decoration: BoxDecoration(
          color: widget.isSelected ? selectedColor : baseColor,// el cambio de color se hace aca
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.nombre,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: widget.sprite.isEmpty
                  ? const Icon(
                      Icons.help_outline_rounded,
                      size: 120,
                      color: Colors.white54,
                    )
                  : Image.network(
                      widget.sprite,
                      scale: 0.6,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
