import 'package:flutter/material.dart';
import 'services/pokemon_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // AQUÍ va el controller
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

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

        body: Center(
          child: SizedBox(
            width: 300,
            child: TextField(
              controller: controller,//aca creo el objeto controller para poder obtener el valor del textfield


              //funcion igual a la de react que me permite obtener el valor del textfield en tiempo real y comprobar que funciona correctamente
               onChanged: (value) {
                print(value);
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
      ),
    );
  }
}