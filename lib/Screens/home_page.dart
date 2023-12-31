import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/NavBar.dart';
import 'package:proyecto_vsn/Screens/balance.dart';
import 'package:proyecto_vsn/Screens/calendar.dart';
import 'package:proyecto_vsn/Screens/gastos.dart';
import 'package:proyecto_vsn/Screens/ingresos.dart';
import 'package:proyecto_vsn/Screens/moves.dart';
import 'package:proyecto_vsn/Screens/profile.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

import 'ahorros.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  final List<String> titles = ['Balance', 'Ingresos', 'Gastos', 'Ahorros'];
  final List<Widget> _pages = [
    const Balance(),
    const Ingresos(),
    const Egresos(),
    Ahorros(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp(
        title: 'Material App',
        home: Scaffold(
          drawer: NavBar(),
          appBar: AppBar(
            elevation: 0,
            title: Text(
              titles[selectedPage],
              style: TextStyle(
                color: themeState.themeData.colorScheme.shadow,
              ),
            ),
            backgroundColor: themeState.themeData.colorScheme.primary,
            iconTheme: IconThemeData(
              color: themeState.themeData.colorScheme.shadow,
            ),
          ),
          body: _pages[selectedPage],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedPage,
            onTap: (int index) {
              setState(() {
                selectedPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.currency_exchange,
                ),
                label: 'Balance',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_circle_up), label: 'Ingresos'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_circle_down), label: 'Gastos'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.savings), label: 'Ahorros'),
            ],
            selectedItemColor: Color.fromARGB(
                255, 15, 182, 138), // Color de los íconos seleccionados
            unselectedItemColor:
                Colors.grey, // Color de los íconos no seleccionados
          ),
        ),
      );
    });
  }
}
