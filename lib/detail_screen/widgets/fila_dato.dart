import 'package:flutter/material.dart';

//esta clase es para mostrar una fila de datos en la pantalla de
//detalles del Pokémon como lo puede ser el nombre, n° pokedex, altura, etc.
class FilaDato extends StatelessWidget {
  final String tipoDatoPokemon;
  final String datoPokemon;

  const FilaDato({
    super.key,
    required this.tipoDatoPokemon,
    required this.datoPokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      //se alinea el label a la izquierda y el valor a la derecha, con un espacio entre ellos
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //dentro de esta sizedbox se muestra el tipo de dato
          SizedBox(
            width: 120,
            child: Text(
              "$tipoDatoPokemon:",
              style: const TextStyle(
                color: Color(0xD24CFEE3),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          //el valor del dato correspondiente al tipoDatoPokemon
          //se muestra a la derecha de este mismo
          Expanded(
            child: Text(
              datoPokemon,
              style: const TextStyle(color: Color(0xFF8FB1FC), fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
