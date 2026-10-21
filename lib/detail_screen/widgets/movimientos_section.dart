import 'package:flutter/material.dart';
import 'package:proyecto_poke_api/data/model/movimiento.dart';
import 'package:proyecto_poke_api/data/model/pokedex_response.dart';
import 'package:proyecto_poke_api/data/repository.dart';

// Sección colapsable de movimientos, agrupados por tipo.
// Al desplegarse, carga los tipos de cada movimiento con peticiones
// a la PokéAPI (carga lazy).
class MovimientosSection extends StatefulWidget {
  final List<String> nombresMovimientos;

  const MovimientosSection({super.key, required this.nombresMovimientos});

  @override
  State<MovimientosSection> createState() => _MovimientosSectionState();
}

class _MovimientosSectionState extends State<MovimientosSection> {
  final Repository _repository = Repository();

  // Se carga solo la primera vez que se despliega
  Future<List<Movimiento>>? _futuroMovimientos;

  void _cargarMovimientos() {
  if (_futuroMovimientos != null) return;

  setState(() {
    _futuroMovimientos = Future.wait(
      widget.nombresMovimientos.map(
        (nombre) => _repository.fetchMovimiento(nombre),
      ),
    );
  });
}

  // Agrupa los movimientos por tipo
  Map<String, List<Movimiento>> _agruparPorTipo(List<Movimiento> movimientos) {
    final agrupados = <String, List<Movimiento>>{};
    for (final mov in movimientos) {
      agrupados.putIfAbsent(mov.tipo, () => []).add(mov);
    }
    return agrupados;
  }

  //representa un chip para mostrar el nombre de un movimiento, con estilo personalizado
  Widget _chipMovimiento(Movimiento mov) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF243256),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        mov.nombre,
        style: const TextStyle(color: Color(0xFFE3C1DC), fontSize: 13),
      ),
    );
  }

  // Bloque por tipo, tiene título y Wrap de chips
  Widget _grupoPorTipo(String tipo, List<Movimiento> movimientos) {
    final tipoTraducido = PokedexResponse.traduccionTipos[tipo] ?? tipo;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$tipoTraducido (${movimientos.length})",
            style: const TextStyle(
              color: Color(0xD200FBFF),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: movimientos.map(_chipMovimiento).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nombresMovimientos.isEmpty) return const SizedBox.shrink();

    return Theme(
      // Quita el divider por defecto del ExpansionTile
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        // Título de la sección con la cantidad de movimientos
        title: Text(
          "Movimientos (${widget.nombresMovimientos.length})",
          style: const TextStyle(
            color: Color(0xDFE47AFF),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white70,
        // Se ejecuta al desplegar (y también al colapsar, pero el guard evita recargar)
        onExpansionChanged: (abierto) {
          if (abierto) _cargarMovimientos();
        },
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: FutureBuilder<List<Movimiento>>(
                future: _futuroMovimientos,
                builder: (context, snapshot) {
                  if (_futuroMovimientos == null) {
                    // Aún no se ha desplegado
                    return const SizedBox.shrink();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    );
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "No se pudieron cargar los movimientos",
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }
              
                  final agrupados = _agruparPorTipo(snapshot.data!);
              
                  // Ordena los grupos por cantidad de movimientos (mayor a menor)
                  final entradasOrdenadas = agrupados.entries.toList()
                    ..sort((a, b) => b.value.length.compareTo(a.value.length));
              
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: entradasOrdenadas
                        .map((e) => _grupoPorTipo(e.key, e.value))
                        .toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
