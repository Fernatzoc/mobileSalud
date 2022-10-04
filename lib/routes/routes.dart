import 'package:flutter/material.dart';
import 'package:mobile_salud/screen/users_screen.dart';
import '../screen/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => const HomeScreen(),
  'login': (_) => const LoginScreen(),
  'loading': (_) => const LoadingScreen(),
  'users': (_) => const UsersScreen(),
  'pregnancy': (_) => const PregnacyScreen(),
  'createUser': (_) => const CreateUserScreen(),
  'createRegister': (_) => const CreateRegisterScreen(),
};
