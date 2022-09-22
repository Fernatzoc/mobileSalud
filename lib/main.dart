import 'package:flutter/material.dart';
import 'package:mobile_salud/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Salud',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
