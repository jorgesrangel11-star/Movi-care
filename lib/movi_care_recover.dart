import 'package:flutter/material.dart';

// Definición de Colores
const Color colorFondoGeneral = Color(0xFFA0EACD);
const Color colorIconoPrincipal = Color(0xFF004D40);
const Color colorNavegacionGPS = Color(0xFF2D9CDB);

class MoviCareRecoverPage extends StatefulWidget {
  const MoviCareRecoverPage({super.key});

  @override
  State<MoviCareRecoverPage> createState() => _MoviCareRecoverPageState();
}

class _MoviCareRecoverPageState extends State<MoviCareRecoverPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String _opcionSeleccionada = 'Email';

  Future<void> _handleRecovery() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulación de envío
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Instrucciones enviadas a $_opcionSeleccionada.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    required bool isVisible,
  }) {
    if (!isVisible) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: colorIconoPrincipal,
                width: 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFondoGeneral,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Título Recuperar cuenta y botón de volver
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recuperar cuenta',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'VOLVER',
                        style: TextStyle(
                          color: colorIconoPrincipal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Logo/Ícono
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorIconoPrincipal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.accessible_forward,
                    size: 80,
                    color: colorFondoGeneral,
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  'Recuperar cuenta',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colorIconoPrincipal,
                  ),
                ),
                const SizedBox(height: 20),

                // Selección de Opción
                Align(
                  alignment: Alignment.centerLeft,
                  child: DropdownButton<String>(
                    value: _opcionSeleccionada,
                    style: TextStyle(fontSize: 16, color: colorIconoPrincipal),
                    items: const [
                      DropdownMenuItem(value: 'Email', child: Text('Email')),
                      DropdownMenuItem(
                        value: 'Teléfono',
                        child: Text('Teléfono'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        _opcionSeleccionada = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Campo Email
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  isVisible: _opcionSeleccionada == 'Email',
                  validator: (value) => (_opcionSeleccionada == 'Email' &&
                          (value == null || !value.contains('@')))
                      ? 'Ingresa un email válido'
                      : null,
                ),

                // Campo Teléfono
                _buildTextField(
                  controller: _telefonoController,
                  labelText: 'Teléfono',
                  keyboardType: TextInputType.phone,
                  isVisible: _opcionSeleccionada == 'Teléfono',
                  validator: (value) => (_opcionSeleccionada == 'Teléfono' &&
                          (value == null || value.length < 10))
                      ? 'Mínimo 10 dígitos'
                      : null,
                ),
                const SizedBox(height: 30),

                // Botón Enviar Instrucciones
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRecovery,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorNavegacionGPS,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 5,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Enviar instrucciones',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
