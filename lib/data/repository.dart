import 'dart:convert';
import 'package:proyecto_poke_api/data/model/movimiento.dart';
import 'package:proyecto_poke_api/data/model/pokedex_response.dart';
import 'package:http/http.dart' as http;

class Repository {
  Future<List<PokedexResponse>?> fetchPokedexInfo(
    String name, {
    int offset = 0,
  }) async {
    //Si no se ha buscado nada, se le pide a la API una lista de los pokemon de 30 en 30 por orden de ID
    if (name.isEmpty) {
      final response = await http.get(
        Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=30&offset=$offset"),
      );

      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body);
        List<dynamic> listJson = decodedJson["results"];

        List<Future<PokedexResponse>> resultados = listJson.map((e) async {
          final detalleResponse = await http.get(Uri.parse(e["url"]));
          var detalleJson = jsonDecode(detalleResponse.body);
          return PokedexResponse.fromJson(detalleJson);
        }).toList();

        return await Future.wait(resultados);
      }
      return null;
    } else {
      final response = await http.get(
        Uri.parse("https://pokeapi.co/api/v2/pokemon/$name"),
      );
      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body);
        PokedexResponse pokedexResponse = PokedexResponse.fromJson(decodedJson);
        return [pokedexResponse];
      } else {
        return null;
      }
    }
  }

  // Obtiene el tipo de un movimiento específico desde la PokéAPI.
  // Se usa para la carga lazy en la sección de movimientos
  Future<Movimiento> fetchMovimiento(String nombre) async {
    final response = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/move/$nombre"),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Movimiento(nombre: nombre, tipo: json["type"]["name"]);
    }
    return Movimiento(nombre: nombre, tipo: "unknown");
  }
    //para buscar el sprite, nombre y otros datos para el juego de hihger or lower
    Future<PokedexResponse?> fetchPokemonById(int id) async {
      final response = await http.get(
        Uri.parse("https://pokeapi.co/api/v2/pokemon/$id"),
      );
      if (response.statusCode == 200) {
        return PokedexResponse.fromJson(jsonDecode(response.body));
      }
      return null;
    }
  }

  //Método que permite obtener todos los nombres de los pokemones de la API, para poder hacer la busqueda en el buscador
  Future<List<String>> fetchAllPokemon() async {
    final response = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=1025"),
    );
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      List<String> names = List<String>.from(
        decodedJson["results"].map((e) => e["name"] as String),
      );
      return names;
    }
    return [];
  }
