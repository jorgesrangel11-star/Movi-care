import 'package:flutter/material.dart';

const Color colorAlertaPeligro = Color(0xFFFF0000);
const Color colorFondoGeneral = Color(0xFFA0EACD);
const Color colorAccionLlamar = Color(
  0xFFE74C3C,
);
const Color colorIconoPrincipal = Color(
  0xFF004D40,
);
const Color colorNavegacionGPS = Color(0xFF2D9CDB);

class MoviCareHomePage extends StatefulWidget {
  const MoviCareHomePage({super.key});

  @override
  State<MoviCareHomePage> createState() => _MoviCareHomePageState();
}

class _MoviCareHomePageState extends State<MoviCareHomePage> {
  String _estadoMonitoreo = "MONITOREANDO";
  bool _alertaActiva = false;

  void _activarAlerta() {
    setState(() {
      _alertaActiva = true;
      _estadoMonitoreo = "ALERTA ACTIVADA";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🚨 ALERTA SOS ENVIADA. Contactos notificados.'),
        backgroundColor: colorAlertaPeligro,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _llamarContacto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📞 Llamando a MAMA...'),
        backgroundColor: Colors.blueGrey,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildPanel({
    required Widget child,
    Color? backgroundColor,
    EdgeInsets padding = const EdgeInsets.all(20),
  }) {
    return Container(
      width: double.infinity,
      color: backgroundColor ?? colorFondoGeneral,
      padding: padding,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFondoGeneral,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPanel(
              padding: const EdgeInsets.only(
                top: 50,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          '< VOLVER',
                          style: TextStyle(
                            color: colorIconoPrincipal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.map, color: colorIconoPrincipal),
                            onPressed: () {
                              Navigator.pushNamed(context, '/map');
                            },
                            tooltip: 'Ver mapa',
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.menu, color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'MOVI-CARE PROTEC',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorIconoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.black54,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'ESTADO: $_estadoMonitoreo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _alertaActiva
                              ? colorAlertaPeligro
                              : colorIconoPrincipal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: GestureDetector(
                      onTap: _activarAlerta,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorAlertaPeligro,
                          boxShadow: [
                            BoxShadow(
                              color: _alertaActiva
                                  ? colorAlertaPeligro.withOpacity(0.8)
                                  : Colors.black26,
                              blurRadius: _alertaActiva ? 25 : 10,
                              spreadRadius: _alertaActiva ? 8 : 0,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'SOS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/map');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorNavegacionGPS,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      icon: const Icon(Icons.map),
                      label: const Text(
                        'VER MAPA DE UBICACIÓN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildPanel(
              padding: const EdgeInsets.all(20),
              backgroundColor: colorFondoGeneral,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título Contacto
                  Text(
                    'CONTACTO DE EMERGENCIA',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorIconoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'MAMA',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorIconoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Info y Botón de Llamada
                  Row(
                    children: [
                      // Imagen del Contacto
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150/FF00FF/FFFFFF?text=MAMA',
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Botón LLAMAR
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _llamarContacto,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorAccionLlamar.withOpacity(0.8),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: colorAccionLlamar,
                                width: 2,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'LLAMAR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
