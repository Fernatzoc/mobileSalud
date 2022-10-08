import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/index.dart';
import 'routes/routes.dart';
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
        ChangeNotifierProvider(create: (_) => PregnancyService()),
        ChangeNotifierProvider(create: (_) => Calculator())
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
