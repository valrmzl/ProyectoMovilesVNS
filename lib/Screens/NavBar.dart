import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/login_page.dart';
import 'package:proyecto_vsn/Screens/profile.dart';
import 'package:proyecto_vsn/Screens/welcome.dart';
import 'package:proyecto_vsn/theme/app_themes.dart';
import '../theme/bloc/theme_bloc.dart';
import 'balance.dart'; 

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  void signUserOut(BuildContext context){
    FirebaseAuth.instance.signOut();
    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));

    print("Log-out");
  }

  bool isSwitched = false;

  /*
  late User user;

  Future<User> loadJsonDataUser() async {
    final jsonString = await rootBundle.loadString('lib/data/user.json');
    final jsonData = json.decode(jsonString);
    var lista = User.fromJson(jsonData);
    return lista;
  }

  @override
  void initState() {
    super.initState();
    loadJsonDataUser().then((value) {
      user = value;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Drawer(
          child: Container(
            color: themeState.themeData.colorScheme.primaryContainer,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text("Valeria Ramirez "),
                  accountEmail: Text("valeria.ramirez@iteso.mx"),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80",
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: themeState
                        .themeData.colorScheme.secondary, // Color del tema
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.app_settings_alt,
                      color:
                          themeState.themeData.colorScheme.onPrimaryContainer),
                  title: Text("Configuracion",
                      style: TextStyle(
                          color: themeState
                              .themeData.colorScheme.onPrimaryContainer)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ));
                  },
                ),
                // Otras opciones del Drawer
                ListTile(
                  leading: Icon(Icons.lightbulb_sharp,
                      color:
                          themeState.themeData.colorScheme.onPrimaryContainer),
                  title: Text("Modo Oscuro",
                      style: TextStyle(
                          color: themeState
                              .themeData.colorScheme.onPrimaryContainer)),
                  trailing: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = !isSwitched;
                        BlocProvider.of<ThemeBloc>(context).add(
                          ThemeChangedEvent(
                            theme: isSwitched
                                ? AppTheme.DarkApp
                                : AppTheme.LightApp,
                          ),
                        );
                      });
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.logout,
                      color:
                          themeState.themeData.colorScheme.onPrimaryContainer),
                  title: Text("Cerrar Sesión",
                      style: TextStyle(
                          color: themeState
                              .themeData.colorScheme.onPrimaryContainer)),
                  onTap: () {
                    signUserOut(context);
                  },
                ),
                // Otras opciones del Drawer
              ],
            ),
          ),
        );
      },
    );
  }
}
