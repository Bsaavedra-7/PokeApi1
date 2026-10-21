import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/data/model/pokedex_response.dart';
import 'package:proyecto_poke_api/detail_screen/widgets/fila_dato.dart';
import 'package:proyecto_poke_api/detail_screen/widgets/sprite_toggle.dart';
import 'package:proyecto_poke_api/detail_screen/widgets/stats_section.dart';
import 'package:proyecto_poke_api/detail_screen/widgets/movimientos_section.dart';

//esta clase es para mostrar la pantalla de detalles de un Pokémon
//como lo son sus datos, sus stats y su sprite, que se puede alternar entre normal y shiny
//además de los movimientos que puede aprender
class PagDetalles extends StatefulWidget {
  final PokedexResponse pokemon;

  const PagDetalles({super.key, required this.pokemon});

  @override
  State<PagDetalles> createState() => _PagDetallesState();
}

class _PagDetallesState extends State<PagDetalles> {
  bool _mostrarShiny = false;

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;

    // La API entrega altura en decímetros y peso en hectogramos → dividir por 10
    final alturaMetros = (pokemon.height / 10).toStringAsFixed(1);
    final pesoKg = (pokemon.weight / 10).toStringAsFixed(1);

    return Scaffold(
      backgroundColor: const Color(0xFF131526),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color(0xFF243256),
        foregroundColor: Colors.white,
        title: Text(pokemon.nombre),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Sprite del Pokémon que se puede tocar para
            //alternar entre normal y shiny
            SpriteToggle(
              spriteNormal: pokemon.sprite,
              spriteShiny: pokemon.shinySprite,
              mostrarShiny: _mostrarShiny,
              onToggle: () => setState(() => _mostrarShiny = !_mostrarShiny),
            ),

            const SizedBox(height: 24),
            const Divider(color: Color(0xFF243256), thickness: 2),
            const SizedBox(height: 16),

            //Datos del Pokémon
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      FilaDato(
                        tipoDatoPokemon: "N° Pokédex",
                        datoPokemon: "#${pokemon.id}",
                      ),
                      FilaDato(
                        tipoDatoPokemon: "Nombre",
                        datoPokemon: pokemon.nombre,
                      ),
                      FilaDato(
                        tipoDatoPokemon: "Tipos",
                        datoPokemon: pokemon.tipos.join(", "),
                      ),
                      FilaDato(
                        tipoDatoPokemon: "Habilidades",
                        datoPokemon: pokemon.abilities.join(", "),
                      ),
                      FilaDato(
                        tipoDatoPokemon: "Altura",
                        datoPokemon: "$alturaMetros m",
                      ),
                      FilaDato(
                        tipoDatoPokemon: "Peso",
                        datoPokemon: "$pesoKg kg",
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                //Stats del Pokémon
                Expanded(child: StatsSection(stats: pokemon.stats)),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(color: Color(0xFF243256), thickness: 2),
            const SizedBox(height: 16),

            //Movimientos que puede aprender el Pokémon
            //(se cargan al desplegar la sección)
            MovimientosSection(nombresMovimientos: pokemon.moves),
          ],
        ),
      ),
    );
  }
}
