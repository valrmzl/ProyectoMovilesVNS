import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/create_account.dart';
import 'package:proyecto_vsn/Screens/login_page.dart';
import 'package:proyecto_vsn/Screens/home_page.dart';
import 'package:proyecto_vsn/Screens/welcome.dart';
import 'package:proyecto_vsn/Screens/calendar.dart';

void main() => runApp(
  MaterialApp(
    title: 'Tarea 3.5',
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        color:Color.fromARGB(255, 47, 125, 121),
      ), 
    ),
    home: Welcome(),
  ),
);


