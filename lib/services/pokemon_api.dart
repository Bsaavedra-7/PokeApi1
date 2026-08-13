import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>>  obtenerPokemon(String nombre) async{

    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$nombre');

    final response = await http.get(url);

    if (response.statusCode == 200){
      final data = jsonDecode(response.body);

      return data;
    }else{
        throw Exception('Error al obtener el Pokémon');
    }
}