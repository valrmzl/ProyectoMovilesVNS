import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/login_page.dart';

void main() => runApp(
  MaterialApp(
    title: 'Tarea 3.5',
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        color: Color.fromARGB(255, 109, 81, 50),
      ), 
    ),
    home: LoginPage(),
  ),
);


