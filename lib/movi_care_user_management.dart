import 'package:flutter/material.dart';

// Definición de Colores
const Color colorFondoGeneral = Color(0xFFA0EACD);
const Color colorAccionModificar = Color(0xFFE74C3C);
const Color colorIconoPrincipal = Color(0xFF004D40);

class MoviCareUserManagementPage extends StatefulWidget {
  const MoviCareUserManagementPage({super.key});

  @override
  State<MoviCareUserManagementPage> createState() =>
      _MoviCareUserManagementPageState();
}

class _MoviCareUserManagementPageState
    extends State<MoviCareUserManagementPage> {
  final TextEditingController _nombreController = TextEditingController(
    text: "Nombre apellido",
  );
  final TextEditingController _rolController = TextEditingController(
    text: "Tutor",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "********",
  );

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _rolSeleccionado = 'Tutor';
  final List<String> _rolesDisponibles = ['Paciente', 'Tutor', 'Administrador'];

  Future<void> _handleModificar() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Usuario modificado. Nuevo rol: $_rolSeleccionado'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool isPassword = false,
    bool isDropdown = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        isDropdown
            ? DropdownButtonFormField<String>(
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
                ),
                items: _rolesDisponibles.map((String rol) {
                  return DropdownMenuItem<String>(value: rol, child: Text(rol));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _rolSeleccionado = newValue!;
                  });
                },
              )
            : TextFormField(
                controller: controller,
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
              ),
        const SizedBox(height: 25),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFondoGeneral,
      appBar: AppBar(
        title: const Text(
          'Gestión de usuarios',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: colorFondoGeneral,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Campo Nombre del Usuario
                _buildTextField(
                  controller: _nombreController,
                  labelText: 'Nombre del usuario',
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'El nombre es obligatorio'
                      : null,
                ),

                // Campo Rol
                _buildTextField(
                  controller: _rolController,
                  labelText: 'Rol',
                  isDropdown: true,
                ),

                // Campo Contraseña
                _buildTextField(
                  controller: _passwordController,
                  labelText: 'Contraseña (Dejar vacío para no cambiar)',
                  isPassword: true,
                  validator: (value) =>
                      (value != null && value.isNotEmpty && value.length < 6)
                          ? 'Mínimo 6 caracteres'
                          : null,
                ),
                const SizedBox(height: 30),

                // Botón Modificar
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleModificar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorAccionModificar,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 5,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Modificar',
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
