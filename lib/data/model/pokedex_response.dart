import 'package:dartx/dartx.dart';

// Modelo que representa la respuesta formateada de un Pokémon traído desde la API
class PokedexResponse {
  final int id;
  final String nombre;
  final List<String> tipos;
  final String sprite;
  final String shinySprite;
  final List<int> stats;
  final List<String> abilities;
  final List<String> moves;
  final int height;
  final int weight;
  final int baseExperience;

  // Diccionario estático para traducir los tipos de inglés a español localmente (para no abusar de la API).
  static const Map<String, String> traduccionTipos = {
    "normal": "Normal",
    "fire": "Fuego",
    "water": "Agua",
    "grass": "Planta",
    "electric": "Eléctrico",
    "ice": "Hielo",
    "fighting": "Lucha",
    "poison": "Veneno",
    "ground": "Tierra",
    "flying": "Volador",
    "psychic": "Psíquico",
    "bug": "Bicho",
    "rock": "Roca",
    "ghost": "Fantasma",
    "dragon": "Dragón",
    "steel": "Acero",
    "fairy": "Hada",
    "dark": "Siniestro",
    "stellar": "Estelar",
    "unknown": "Desconocido",
    "shadow": "Sombra",
  };

  //Para que se puedan pedir datos a la API como una lista
  static List<PokedexResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PokedexResponse.fromJson(json)).toList();
  }

  PokedexResponse({
    required this.id,
    required this.nombre,
    required this.tipos,
    required this.sprite,
    required this.shinySprite,
    required this.stats,
    required this.abilities,
    required this.moves,
    required this.height,
    required this.weight,
    required this.baseExperience,
  });

  // Constructor de tipo factory que convierte el JSON recibido de la PokéAPI a la clase PokedexResponse.
  factory PokedexResponse.fromJson(Map<String, dynamic> json) {
    return PokedexResponse(
      id: json["id"],
      nombre: (json["name"] as String).capitalize(),
      tipos: List<String>.from(
        json["types"].map(
          (e) =>traduccionTipos[e["type"]["name"]] ?? e["type"]["name"].capitalize(),
        ),
      ),
      sprite: json["sprites"]["front_default"] ?? '',
      shinySprite: json["sprites"]["front_shiny"] ?? '',
      stats: List<int>.from(json["stats"].map((e) => e["base_stat"] as int)),
      abilities: List<String>.from(
        json["abilities"].map((e) => e["ability"]["name"]),
      ),
      moves: List<String>.from(json["moves"].map((e) => e["move"]["name"])),
      baseExperience: json["base_experience"] as int,
      height: json["height"] as int,
      weight: json["weight"] as int,
    );
  }
}
