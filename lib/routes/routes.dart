import 'package:flutter/material.dart';
import '../screen/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => const HomeScreen(),
  'login': (_) => const LoginScreen(),
  'loading': (_) => const LoadingScreen(),
};
