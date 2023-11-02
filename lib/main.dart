import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/create_account.dart';
import 'package:proyecto_vsn/Screens/login_page.dart';
import 'package:proyecto_vsn/Screens/home_page.dart';
import 'package:proyecto_vsn/Screens/welcome.dart';
import 'package:proyecto_vsn/Screens/calendar.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

void main() {
  // BLoC provider con socope para poder cambiar themes en toda la app
  runApp(BlocProvider(
    create: (context) => ThemeBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BLoC builder para cambiar theme de la Material App
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Change Themes App',
          theme: state.themeData,
          home: HomePage(),
        );
      },
    );
  }
}

/*
void main() => runApp(
  
  MaterialApp(
    title: 'Tarea 3.5',
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        color:Color.fromARGB(255, 47, 125, 121),
      ), 
    ),
    home: HomePage(),
  ),
);

*/
