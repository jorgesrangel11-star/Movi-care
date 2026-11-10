import 'package:flutter/material.dart';

const Color colorFondoGeneral = Color(0xFFA0EACD);
const Color colorNavegacionGPS = Color(0xFF2D9CDB); // Azul Cian
const Color colorIconoPrincipal = Color(0xFF004D40);

class MoviCareMapPage extends StatelessWidget {
  const MoviCareMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFondoGeneral,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.accessible_forward,
                      size: 30,
                      color: colorIconoPrincipal,
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '< VOLVER',
                        style: TextStyle(
                          color: colorIconoPrincipal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 30, color: colorIconoPrincipal),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'MAPA',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorIconoPrincipal,
              ),
            ),
          ),

          // --- VENTANA DEL MAPA REALISTA ---
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    // Fondo de mapa tipo Google Maps
                    Container(
                      color: const Color(0xFFE9F5FB),
                      child: CustomPaint(
                        painter: RealisticMapPainter(),
                        size: Size.infinite,
                      ),
                    ),

                    // Icono de ubicación principal
                    Positioned(
                      left: 150,
                      top: 100,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: const Text(
                              'TÚ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Hospital cercano
                    Positioned(
                      left: 250,
                      top: 180,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.local_hospital,
                            color: Colors.green,
                            size: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Hospital',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Casa
                    Positioned(
                      left: 80,
                      top: 200,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.home,
                            color: Colors.blue,
                            size: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Casa',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Ruta trazada
                    Positioned(
                      left: 100,
                      top: 120,
                      child: CustomPaint(
                        painter: RoutePainter(),
                        size: const Size(200, 100),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // UBICACION DETECTADA
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colorIconoPrincipal, width: 1),
                  ),
                  child: Text(
                    'UBICACION DETECTADA',
                    style: TextStyle(
                      color: colorIconoPrincipal,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Dirección
                const Text(
                  'AV. PIE DE LA CUESTA #2502',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 25),

                // Botón TRAZAR RUTA
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Simulando trazo de ruta...'),
                          backgroundColor: colorNavegacionGPS,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorNavegacionGPS,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'TRAZAR RUTA',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Pintor para mapa realista
class RealisticMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Fondo
    paint.color = const Color(0xFFE9F5FB);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Calles principales
    paint.color = Colors.grey[800]!;
    paint.strokeWidth = 25;

    // Calle horizontal principal
    canvas.drawLine(
      Offset(0, size.height * 0.4),
      Offset(size.width, size.height * 0.4),
      paint,
    );

    // Calle vertical principal
    canvas.drawLine(
      Offset(size.width * 0.5, 0),
      Offset(size.width * 0.5, size.height),
      paint,
    );

    // Calles secundarias
    paint.color = Colors.grey[600]!;
    paint.strokeWidth = 15;

    // Calle horizontal secundaria
    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.7),
      paint,
    );

    // Calle vertical secundaria
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      paint,
    );

    // Parques/áreas verdes
    paint.color = const Color(0xFF90EE90);
    final parkRect = Rect.fromCircle(
      center: Offset(size.width * 0.7, size.height * 0.2),
      radius: 40,
    );
    canvas.drawOval(parkRect, paint);

    // Edificios (rectángulos)
    paint.color = Colors.brown[400]!;
    final building1 = Rect.fromLTWH(100, 250, 40, 80);
    final building2 = Rect.fromLTWH(300, 150, 60, 100);
    final building3 = Rect.fromLTWH(200, 300, 50, 70);

    canvas.drawRect(building1, paint);
    canvas.drawRect(building2, paint);
    canvas.drawRect(building3, paint);

    // Líneas divisorias en calles
    paint.color = Colors.yellow;
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.stroke;

    // Línea punteada en calle principal
    final dashWidth = 10.0;
    final dashSpace = 5.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height * 0.4),
        Offset(startX + dashWidth, size.height * 0.4),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Pintor para ruta
class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.7)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(
        size.width * 0.3, size.height * 0.5, size.width, size.height);

    canvas.drawPath(path, paint);

    // Puntos en la ruta
    paint.style = PaintingStyle.fill;
    paint.color = Colors.blue;

    canvas.drawCircle(const Offset(0, 0), 5, paint); // Inicio
    canvas.drawCircle(Offset(size.width, size.height), 5, paint); // Fin
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
