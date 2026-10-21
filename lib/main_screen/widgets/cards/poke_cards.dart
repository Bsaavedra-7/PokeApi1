import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/data/model/pokedex_response.dart';
import 'package:proyecto_poke_api/main_screen/widgets/cards/poke_card_item.dart';
import 'package:proyecto_poke_api/detail_screen/pag_detalles.dart';

//esta clase es para mostrar la/s tarjetas de pokémon en la pantalla principal,
//si hay un solo resultado se muestra en una tarjeta grande, si hay varios resultados
//se muestran en una cuadrícula de tarjetas pequeñas
class PokeCard extends StatelessWidget {
  final Future<List<PokedexResponse>?>? pokedexInfo;

  const PokeCard({super.key, this.pokedexInfo});

  @override
  Widget build(BuildContext context) {
    if (pokedexInfo == null) return const SizedBox.shrink();

    return FutureBuilder(
      future: pokedexInfo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        } else if (snapshot.hasError) {
          debugPrint(
            "Ocurrió un error al buscar el pokémon :( ${snapshot.error}",
          );
          return const Text("");
        } else if (snapshot.hasData) {
          final listaPokemones = snapshot.data!;

          //Si solo hay un resultado, se presenta en una tarjeta grande
          if (listaPokemones.length == 1) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 280,
                  child: PokeCardItem(
                    pokemon: listaPokemones[0],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PagDetalles(pokemon: listaPokemones[0]),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            //Si son varios resultados, se presenta en cuadrícula
            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                shrinkWrap: true,
                //Se scrollea la pantalla completa, no solo el grid
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),

                itemCount: listaPokemones.length,
                itemBuilder: (context, index) {
                  return PokeCardItem(
                    pokemon: listaPokemones[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PagDetalles(pokemon: listaPokemones[index]),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return const Text("El pokémon no ha sido encontrado");
        }
      },
    );
  }
}
