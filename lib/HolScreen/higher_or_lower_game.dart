import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/main_screen/widgets/poke_logo.dart';
import 'package:proyecto_poke_api/HolScreen/poke_sprite_card.dart';
import '../data/repository.dart';
import '../data/model/pokedex_response.dart';
import 'dart:math';
import '../minijuegos.dart';

void main() => runApp(const HigherOrLowerApp());

class Question {
  final String text;
  final String stat;
  final int num;

  Question({required this.text, required this.stat, required this.num});
}

//funcion que entrega los 2 nums aleatorios que son los id de los pokemin del juego
List<int> numerosAleatorios(int cantidad, int maximo) {
  final random = Random();
  final numeros = <int>{};

  while (numeros.length < cantidad) {
    numeros.add(random.nextInt(maximo));
  }
  debugPrint("Números aleatorios: $numeros");

  return numeros.toList();
}

class HigherOrLowerApp extends StatefulWidget {
  const HigherOrLowerApp({super.key});

  @override
  State<HigherOrLowerApp> createState() => _HigherOrLowerAppState();
}

class _HigherOrLowerAppState extends State<HigherOrLowerApp> {
  final Repository _repository = Repository();
  PokedexResponse? _pokemon1;
  PokedexResponse? _pokemon2;
  int? _selectedIndex;
  int _numQuestion = 0;
  bool _isRoundActive = false;

  @override
  void initState() {
    super.initState();
    _loadRandomPokemon();
    _numQuestion = Random().nextInt(preguntas.length);
    //print("Pregunta inicial: $_numQuestion");
  }

  //aca movi el codigo de cargar los pokemon poara el juego
  Future<void> _loadRandomPokemon() async {
    final ids = numerosAleatorios(2, 1025);
    final results = await Future.wait([
      _repository.fetchPokemonById(ids[0]),
      _repository.fetchPokemonById(ids[1]),
    ]);
    if (mounted) {
      setState(() {
        _pokemon1 = results[0];
        _pokemon2 = results[1];
        _selectedIndex = null;
      });
    }
  }

  void _handleclick(int index) {
    if (_isRoundActive) return; // esto evita el click mientras se muestra el snackbar
    _isRoundActive = true;
    setState(() => _selectedIndex = index);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _selectedIndex = null);
    });

    final question = preguntas[_numQuestion];
    int stat1, stat2;

    // switch para cada caso
    switch (question.num) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        stat1 = _pokemon1!.stats[question.num];
        stat2 = _pokemon2!.stats[question.num];
        break;
      case 6:
        stat1 = _pokemon1!.baseExperience;
        stat2 = _pokemon2!.baseExperience;
        break;
      case 7:
        stat1 = _pokemon1!.height;
        stat2 = _pokemon2!.height;
        break;
      case 8:
        stat1 = _pokemon1!.weight;
        stat2 = _pokemon2!.weight;
        break;
      default:
        debugPrint("Error, numero invalido: ${question.num}");
        return;
    }
    // la logica que compara la respuesta, no estoy seguro si esta bien jajaja
    bool isCorrect;
    if (index == 0) {
      isCorrect = stat1 >= stat2;
      debugPrint("Respuesta correcta");
    } else {
      isCorrect = stat2 >= stat1;
      debugPrint("Respuesta incorrecta");
    }

    // snackbar me permite mostar un mensaje emerjente que muestra si es correcto o incorrecto y dura solo 1.5 segundos
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? "¡Respuesta correcta!" : "¡Respuesta incorrecta!",
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: const Duration(
          milliseconds: 1500,
        ), //1.5 sugundos, me parecio suficiente tiempo y no exesivo
      ),
    );

    // esto permite que el juego siga ejecutadoso depspues de 1,5s
    Future.delayed(const Duration(milliseconds: 1500), () async {
      if (!mounted) return;
      await _loadRandomPokemon();
      setState(() {
        _numQuestion = Random().nextInt(preguntas.length);
        _isRoundActive = false;//aca terminan el snackbar y puede seguir el juego
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131526),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF243256),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        titleSpacing: 24,
        title: Row(children: [const SizedBox(width: 250, child: PokeLogo())]),
        actions: [
          IconButton(
            icon: const Icon(Icons.sports_esports, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (e) => const MinijuegosApp()),
            ),
          ),
        ],
      ),
      body: _pokemon1 == null || _pokemon2 == null
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      preguntas[_numQuestion].text,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: PokeSpriteCard(
                            //pokemon 1
                            id: _pokemon1!.id,
                            nombre: _pokemon1!.nombre,
                            sprite: _pokemon1!.sprite,
                            onTap: () => _handleclick(0),
                            isSelected: _selectedIndex == 0,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: PokeSpriteCard(
                            //pokemon 2
                            id: _pokemon2!.id,
                            nombre: _pokemon2!.nombre,
                            sprite: _pokemon2!.sprite,
                            onTap: () => _handleclick(1),
                            isSelected: _selectedIndex == 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

/* 

data.stats[0].base_stat → HP
data.stats[1].base_stat → Attack
data.stats[2].base_stat → Defense
data.stats[3].base_stat → Sp. Attack
data.stats[4].base_stat → Sp. Defense
data.stats[5].base_stat → Speed

*/

var preguntas = [
  Question(
    text: "¿Cual pokemon tiene mayor defensa especial?",
    stat: "special-defense",
    num: 4,
  ),

  Question(
    text: "¿Cual pokemon tiene mayor ataque especial?",
    stat: "special-attack",
    num: 3,
  ),

  Question(text: "¿Cual pokemon tiene mayor HP?", stat: "hp", num: 0),

  // numero - 3
  Question(text: "¿Cual pokemon tiene mayor velocidad?", stat: "speed", num: 5),

  Question(text: "¿Cual pokemon tiene mayor defensa?", stat: "defense", num: 2),

  Question(text: "¿Cual pokemon tiene mayor ataque?", stat: "attack", num: 1),

  Question(
    text: "¿Cual pokemon tiene mayor experiencia base?",
    stat: "base-experience",
    num:
        6, //-> si el num es 6 significa que no es un stat, sino otra propiedad del pokemon, en este caso la experiencia base
  ),

  Question(text: "¿Cual pokemon tiene mayor altura?", stat: "height", num: 7),

  Question(text: "¿Cual pokemon tiene mayor peso?", stat: "weight", num: 8),
];
