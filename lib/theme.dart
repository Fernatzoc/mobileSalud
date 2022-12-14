import 'package:flutter/material.dart';

final theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color(0xffF2F6FC),
    primaryColor: const Color(0xff6A7AFA),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: const Color(0xff6A7AFA),
        ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Color(0xff6A7AFA)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff6A7AFA),
    ));
