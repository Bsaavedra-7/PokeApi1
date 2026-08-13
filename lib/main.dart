import 'package:flutter/material.dart';
import 'dart:async';
import 'services/pokemon_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState(); //state como en react

}

class _MyAppState extends State<MyApp> {

  // AQUÍ va el controller
  final TextEditingController controller = TextEditingController();

  //aca creo otro estado que guardara los datos del pokemon en un array de tipo map
  Map<String, dynamic>? pokemon;

  Timer? debounce;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
      ),

      home: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          toolbarHeight: 80,

          title: const Text(
            'Pokedex',
            style: TextStyle(
              fontFamily: 'comic-sans',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        body: Column(
          children: [

            // INPUT
            Center(
              child: SizedBox(
                width: 300,
                child: TextField(
                  controller: controller,

                  onChanged: (value) async {
                    if(value.isEmpty){
                      return;
                    }

                    //debounce es una funcion que genera un tiempo de espera para que no hayan muchas peticiones  a al api
                    debounce?.cancel();
                    debounce = Timer(const Duration(milliseconds: 500), () async {
                      try {
                        final data = await obtenerPokemon(value.toLowerCase());
                        setState(() {
                          pokemon = data;
                        });
                      } catch (e) {
                        setState(() {
                          pokemon = null;
                        });
                      }
                    });

                  },

                  decoration: InputDecoration(
                    hintText: 'Escribe un Pokémon',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),

            // RESULTADO
            if (pokemon != null)
              Column(
                children: [
                  Text(
                    pokemon!["name"],
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Altura: ${pokemon!["height"]}",
                  ),

                  Text(
                    "Peso: ${pokemon!["weight"]}",
                  ),

                  Image.network(
                    pokemon!["sprites"]["front_default"],
                  ),

                  Text(
                    "Tipos: ${pokemon!["types"].map((t) => t["type"]["name"]).join(", ")}",
                  ),

                 Text("N°${pokemon!["id"]}"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}