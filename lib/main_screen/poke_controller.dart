import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/data/model/pokedex_response.dart';
import 'package:proyecto_poke_api/data/repository.dart';

// Controlador que gestiona la lógica y el estado de la Pokédex.
// Hereda de ChangeNotifier para notificar a la interfaz cuando hay cambios.
class PokedexController extends ChangeNotifier {
  // Instancia del repositorio para hacer las peticiones a la PokéAPI.
  final Repository repository = Repository();

  // Guarda la información del Pokémon seleccionado (se resuelve mediante un Future).
  Future<List<PokedexResponse>?>? pokedexInfo;

  // Lista con los nombres de todos los Pokémon obtenidos de la API.
  List<String> allPokemonNames = [];

  // Lista filtrada que se muestra en el menú desplegable.
  List<String> sugerencias = [];

  // Indica si el menú de sugerencias debe estar visible.
  bool showSuggestions = false;

  // La "página" actual de los pokemones que se presentan por defecto
  int offsetActual = 0;

  // Modo para activar o desactivar los botones de navegación
  bool modoGrid = true;

  // Carga la lista inicial de todos los nombres de Pokémon.
  Future<void> loadPokemonNames() async {
    final rawNames = await fetchAllPokemon();
    allPokemonNames = rawNames.map((name) => name.capitalize()).toList();
    notifyListeners(); // Avisa a la vista que ya se cargaron los nombres.
  }

  // Filtra la lista de Pokémon según el texto ingresado en el buscador.
  void filterSuggestions(String input) {
    //Si no se ha escrito nada en el buscador, ahora presenta los pokemones por defecto
    if (input.isEmpty) {
      modoGrid = true;
      sugerencias = [];
      showSuggestions = false;
      cargarGridInicial();
    } else {
      modoGrid = false;
      pokedexInfo = null; // Limpia la tarjeta actual mientras se busca algo nuevo.

      // Busca coincidencias sin importar mayúsculas o minúsculas.
      sugerencias = allPokemonNames
          .where((name) => name.toLowerCase().contains(input.toLowerCase()))
          .toList();
      showSuggestions = true;

      notifyListeners(); // Actualiza la pantalla para mostrar u ocultar la lista.
    }
  }

  // Se ejecuta al tocar un Pokémon de la lista de sugerencias.
  void selectPokemon(String name) {
    modoGrid = false;
    pokedexInfo = repository.fetchPokedexInfo(name.toLowerCase()); // Solicita los datos a la API.
    showSuggestions = false; // Oculta el menú desplegable.
    notifyListeners(); // Actualiza la vista con la nueva consulta.
  }

  // Pide los 30 primeros pokemones a la API
  void cargarGridInicial() {
    offsetActual = 0;
    _cargarPagina();
  }

  // Métodos para cambiar y cargar los 30 pokemones actuales
  void _cargarPagina() {
    pokedexInfo = repository.fetchPokedexInfo("", offset: offsetActual);
    notifyListeners();
  }

  void sigPaginaPokemones() {
    offsetActual += 30;
    _cargarPagina();
  }

  void antPaginaPokemones() {
    if (offsetActual >= 30) {
      offsetActual -= 30;
      _cargarPagina();
    }
  }
}