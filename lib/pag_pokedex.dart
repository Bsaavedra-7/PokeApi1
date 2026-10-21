import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/main_screen/appbar.dart';
import 'package:proyecto_poke_api/main_screen/poke_controller.dart';
import 'package:proyecto_poke_api/main_screen/widgets/botones_navegacion_pokemones.dart';
import 'package:proyecto_poke_api/main_screen/widgets/cards/poke_cards.dart';
import 'package:proyecto_poke_api/main_screen/widgets/buscador/poke_sugerencias.dart';

void main() {
  runApp(const MainPokedex());
}

class MainPokedex extends StatefulWidget {
  const MainPokedex({super.key});

  @override
  State<MainPokedex> createState() => _MainPokedexState();
}

class _MainPokedexState extends State<MainPokedex> {
  final PokedexController _controller = PokedexController();
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller.loadPokemonNames();
    //Al iniciar, carga de inmediato los 30 primeros pokemones
    _controller.cargarGridInicial();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(Colors.grey),
          thickness: WidgetStateProperty.all(8),
          radius: const Radius.circular(10),
        ),
      ),

      home: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Scaffold(
                appBar: PokeAppBar(
                  controller: _controller,
                  layerLink: _layerLink,
                ),
                body: Container(
                  color: const Color(0xFF131526),
                  width: double.infinity,
                  height: double.infinity,
                  //Para scrollear la pantalla completa debajo de la barra de búsqueda
                  child: SingleChildScrollView(
                    child: Column(
                      children: [                      
                        PokeCard(pokedexInfo: _controller.pokedexInfo),

                        //Los botones para cambiar de "página" de los pokemones iniciales
                        BotonesNavegacionPokemones(controller: _controller),
                      ],
                    ),
                  ),
                ),
              ),

              // Se invoca el widget desacoplado únicamente si hay sugerencias activas.
              if (_controller.showSuggestions)
                PokeSuggestionsDropdown(
                  controller: _controller,
                  layerLink: _layerLink,
                ),
            ],
          );
        },
      ),
    );
  }
}