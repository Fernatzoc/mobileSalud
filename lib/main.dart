import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user_service.dart';
import 'routes/routes.dart';
import 'providers/auth_service.dart';
import 'theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UserService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Salud',
        initialRoute: 'loading',
        routes: appRoutes,
        theme: theme,
      ),
    );
  }
}
