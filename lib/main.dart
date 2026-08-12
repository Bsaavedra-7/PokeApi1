import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
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
          )
        ),
        body: const Center(
          child: Text('Hola Mundo'),
        ),
      ),
    );
  }
}