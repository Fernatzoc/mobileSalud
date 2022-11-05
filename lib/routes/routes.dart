import 'package:flutter/material.dart';
import 'package:mobile_salud/screen/update_user_screen.dart';
import '../screen/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => const HomeScreen(),
  'login': (_) => const LoginScreen(),
  'loading': (_) => const LoadingScreen(),
  'users': (_) => const UsersScreen(),
  'singleUser': (_) => const SingleUserScreen(),
  'pregnancy': (_) => const PregnacyScreen(),
  'createUser': (_) => const CreateUserScreen(),
  'updateUser': (_) => const UpdateUserScreen(),
  'createRegister': (_) => const CreateRegisterScreen(),
  'updateRegister': (_) => const UpdateRegisterScreen(),
  'singlePregnant': (_) => const SinglePregnantScreen(),
  'calculator': (_) => const CalculatorScreen(),
  'report': (_) => const ReportScreen(),
  'forgotPassword': (_) => const ForgotPasswordScreen()
};
