import 'package:flutter/material.dart';
import 'movi_care_login.dart';
import 'movi_care_register.dart';
import 'movi_care_recover.dart';
import 'movi_care_home.dart';
import 'movi_care_map.dart';
import 'movi_care_user_management.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movi-Care',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004D40),
          background: const Color(0xFFA0EACD),
        ),
        scaffoldBackgroundColor: const Color(0xFFA0EACD),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MoviCareLoginPage(),
        '/register': (context) => const MoviCareRegisterPage(),
        '/recover': (context) => const MoviCareRecoverPage(),
        '/home': (context) => const MoviCareHomePage(),
        '/map': (context) => const MoviCareMapPage(),
        '/users': (context) => const MoviCareUserManagementPage(),
      },
    );
  }
}
