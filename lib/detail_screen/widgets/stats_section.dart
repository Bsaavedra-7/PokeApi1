import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/detail_screen/widgets/stat_bar.dart';

//esta clase es para mostrar la seccion de estadisticas
//en la pantalla de detalles del Pokémon
class StatsSection extends StatelessWidget {
  //respuesta de la API
  final List<int> stats;

  // Nombres en el mismo orden que la PokéAPI
  static const List<String> _nombresStats = [
    "HP",
    "Ataque",
    "Defensa",
    "Ataque Esp.",
    "Defensa Esp.",
    "Velocidad",
  ];

  const StatsSection({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Estadísticas base",
          style: TextStyle(
            color: Color(0xDFE47AFF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        //genera una lista de stats.length elementos de tipo StatBar
        //en cada indice e i crea un StatBar respectivo al nombre y valor de la estadistica
        //el ... antes de Lis.generate es para que cada elemento quede como hijo de column
        //ejemplo: sin ... sería [a,[b,c,d]] y gracias al ... es [a,b,c,d]
        ...List.generate(
          stats.length,
          (i) => StatBar(
            nombre: _nombresStats[i],
            valor: stats[i],
          ),
        ),
      ],
    );
  }
}
