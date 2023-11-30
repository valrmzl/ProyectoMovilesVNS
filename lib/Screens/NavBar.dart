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
  User? currentUser;

  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }

  Future<dynamic> getData() async {
    currentUser = FirebaseAuth.instance.currentUser;
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
    return FutureBuilder<dynamic>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is being fetched, display a loading indicator or placeholder
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors
            return Text('Error: ${snapshot.error}');
          } else {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                isSwitched =
                    themeState.themeData.toString() == 'ThemeData#0b03e'
                        ? true
                        : false;
                return Drawer(
                  child: Container(
                    color: themeState.themeData.colorScheme.primaryContainer,
                    child: ListView(
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: Text(currentUser?.displayName ?? 'null'),
                          accountEmail: Text(currentUser?.email ?? 'null'),
                        currentAccountPicture: CircleAvatar(
                          radius: 45,
                          child: ClipOval(
                            child: currentUser?.photoURL != null
                                ? Image.asset(
                                    "assets/images/${currentUser?.photoURL}.png",
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  )
                                : Container(), // Add a placeholder or default image if photoURL is null
                          ),
                        ),
                          decoration: BoxDecoration(
                            color: themeState.themeData.colorScheme
                                .secondary, // Color del tema
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.app_settings_alt,
                              color: themeState
                                  .themeData.colorScheme.onPrimaryContainer),
                          title: Text("Configuracion",
                              style: TextStyle(
                                  color: themeState.themeData.colorScheme
                                      .onPrimaryContainer)),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ));
                          },
                        ),
                        // Otras opciones del Drawer
                        ListTile(
                          leading: Icon(Icons.lightbulb_sharp,
                              color: themeState
                                  .themeData.colorScheme.onPrimaryContainer),
                          title: Text("Modo Oscuro",
                              style: TextStyle(
                                  color: themeState.themeData.colorScheme
                                      .onPrimaryContainer)),
                          trailing:
                              // IconButton(
                              //   icon: Icon(Icons.color_lens),
                              //   onPressed: () {
                              //     setState(() {
                              //       BlocProvider.of<ThemeBloc>(context).add(
                              //         ThemeChangedEvent(
                              //           theme: isSwitched
                              //               ? AppTheme.DarkApp
                              //               : AppTheme.LightApp,
                              //         ),
                              //       );
                              //     });
                              //   },
                              // )
                              Switch(
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
                                print("aqui");
                                print(isSwitched);
                                print(themeState.themeData);
                              });
                            },
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.logout,
                              color: themeState
                                  .themeData.colorScheme.onPrimaryContainer),
                          title: Text("Cerrar Sesión",
                              style: TextStyle(
                                  color: themeState.themeData.colorScheme
                                      .onPrimaryContainer)),
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
        });
  }
}
