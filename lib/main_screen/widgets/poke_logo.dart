import 'package:flutter/material.dart';

// Widget que muestra el logo de la Pokédex.
// Se utiliza desde PokeAppBar, en la zona izquierda de la barra,
// para mostrar el logo de la aplicación.
class PokeLogo extends StatelessWidget {
  const PokeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      height: 45,
      fit: BoxFit.contain,
    );
  }
}