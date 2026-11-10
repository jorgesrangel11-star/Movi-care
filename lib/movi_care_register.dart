import 'package:flutter/material.dart';

// Definición de Colores
const Color colorFondoGeneral = Color(0xFFA0EACD);
const Color colorAlertaPeligro = Color(0xFFC0392B);
const Color colorIconoPrincipal = Color(0xFF004D40);

class MoviCareRegisterPage extends StatefulWidget {
  const MoviCareRegisterPage({super.key});

  @override
  State<MoviCareRegisterPage> createState() => _MoviCareRegisterPageState();
}

class _MoviCareRegisterPageState extends State<MoviCareRegisterPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _rolSeleccionado = 'Paciente';
  bool _isLoading = false;
  final List<String> _roles = ['Paciente', 'Tutor'];

  Future<void> _handleRegistro() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Registro exitoso. Inicia sesión.'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
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
          obscureText: isPassword,
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
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Registro',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
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
                    Icons.person_add,
                    size: 80,
                    color: colorFondoGeneral,
                  ), // Ícono de registro
                ),
                const SizedBox(height: 20),

                Text(
                  'Crear cuenta',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colorIconoPrincipal,
                  ),
                ),
                const SizedBox(height: 30),

                // Campo Nombre
                _buildTextField(
                  controller: _nombreController,
                  labelText: 'Nombre',
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Ingresa tu nombre'
                      : null,
                ),

                // Campo Email
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => (value == null || !value.contains('@'))
                      ? 'Ingresa un email válido'
                      : null,
                ),

                // Campo Teléfono
                _buildTextField(
                  controller: _telefonoController,
                  labelText: 'Teléfono (Opcional)',
                  keyboardType: TextInputType.phone,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rol',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: _rolSeleccionado,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: colorIconoPrincipal,
                            width: 2,
                          ),
                        ),
                      ),
                      items: _roles.map((String rol) {
                        return DropdownMenuItem<String>(
                          value: rol,
                          child: Text(rol),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() => _rolSeleccionado = newValue!);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

                // Campo Contraseña
                _buildTextField(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  isPassword: true,
                  validator: (value) => (value == null || value.length < 6)
                      ? 'Mínimo 6 caracteres'
                      : null,
                ),
                const SizedBox(height: 30),

                // Botón Registrar
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegistro,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorAlertaPeligro,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 5,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Registrar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // Enlace a Login
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Ya tengo cuenta',
                    style: TextStyle(
                      color: colorIconoPrincipal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
