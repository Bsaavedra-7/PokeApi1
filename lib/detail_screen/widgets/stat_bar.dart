import 'package:flutter/material.dart';

//esta clase designa el como se ve una barra de estadistica

class StatBar extends StatelessWidget {
  final String nombre;
  final int valor;

  const StatBar({super.key, required this.nombre, required this.valor});

  // Color según qué tan alto sea el stat (el maximo es 255)
  Color _colorStat(int valor) {
    if (valor < 50) return const Color(0xFFAD0505);
    if (valor < 80) return const Color(0xFFED780B);
    if (valor < 110) return const Color(0xFFCDE722);
    return const Color(0xFF05B116);
  }

  @override
  Widget build(BuildContext context) {
    // El valor se normaliza a un rango de 0.0 a 1.0
    final porcentaje = (valor / 255).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          //aqui se muestra el nombre de la estadistica
          SizedBox(
            width: 110,
            child: Text(
              nombre,
              style: const TextStyle(
                color: Color(0xD24CFEE3),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //aqui se muestra el valor de la estadistica
          SizedBox(
            width: 40,
            child: Text(
              "$valor",
              style: const TextStyle(
                color: Color(0xFFB6CBF9),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //aqui se muestra la barra de la estadistica
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: porcentaje,
                minHeight: 10,
                backgroundColor: const Color(0xFF243256),
                valueColor: AlwaysStoppedAnimation(_colorStat(valor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
