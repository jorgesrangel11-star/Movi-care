import 'package:flutter/material.dart';

const Color colorFondoGeneral = Color(0xFFA0EACD);
const Color colorAlertaPeligro = Color(0xFFC0392B);
const Color colorIconoPrincipal = Color(0xFF004D40);

class MoviCareLoginPage extends StatefulWidget {
  const MoviCareLoginPage({super.key});

  @override
  State<MoviCareLoginPage> createState() => _MoviCareLoginPageState();
}

class _MoviCareLoginPageState extends State<MoviCareLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);

        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
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
          obscureText: isPassword && !_passwordVisible,
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
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
            hintText: labelText == 'Email' ? 'nombre@ejemplo.com' : '********',
            hintStyle: const TextStyle(color: Colors.grey),
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
                    'Login',
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
                    Icons.accessible_forward,
                    size: 80,
                    color: colorFondoGeneral,
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  'Inicio de sesión',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colorIconoPrincipal,
                  ),
                ),
                const SizedBox(height: 30),

                // Campos de Texto
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  validator: (value) => (value == null || !value.contains('@'))
                      ? 'Ingresa un email válido'
                      : null,
                ),
                _buildTextField(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  isPassword: true,
                  validator: (value) => (value == null || value.length < 6)
                      ? 'Mínimo 6 caracteres'
                      : null,
                ),
                const SizedBox(height: 30),

                // Botón Iniciar Sesión
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
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
                            'Iniciar sesión',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // Botones Sociales
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade400,
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Google',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3b5998),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Facebook',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/recover');
                  },
                  child: Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                      color: colorIconoPrincipal,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    '¿No tienes cuenta? Regístrate aquí',
                    style: TextStyle(
                      color: colorIconoPrincipal,
                      fontWeight: FontWeight.bold,
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
