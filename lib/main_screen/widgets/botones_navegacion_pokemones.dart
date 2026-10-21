import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/main_screen/poke_controller.dart';

//Clase para los botones de navegacion entre los pokemones que se presentan por defecto
class BotonesNavegacionPokemones extends StatelessWidget {
  final PokedexController controller;

  const BotonesNavegacionPokemones({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.modoGrid) {
      //Si se está escribiendo o se seleccionó un pokemon, los botones desaparecen
      return const SizedBox.shrink();
    } else {
      //Los botones siempre toman un 25% del tamaño total de la pantalla
      final anchoBotones = MediaQuery.of(context).size.width * 0.25;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: anchoBotones,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF396CAF),
                  foregroundColor: Colors.white,

                  padding: EdgeInsets.symmetric(vertical: 18,),

                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                onPressed: controller.offsetActual == 0
                           ? null
                           : () => controller.antPaginaPokemones(),
                child: const Text("<"),
              ),
            ),

            SizedBox(
              width: anchoBotones,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF396CAF),
                  foregroundColor: Colors.white,

                  padding: EdgeInsets.symmetric(vertical: 18),

                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                onPressed: controller.offsetActual >= 1326
                           ? null
                           : () => controller.sigPaginaPokemones(),
                child: const Text(">"),
              ),
            ),
          ],
        )
      );
    }
  }
}