import 'package:http/http.dart' as http;

Future<void>  obtenerPokemon(String nombre) async{

    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$nombre');

    final response = await http.get(url);

    print(response.body);

}