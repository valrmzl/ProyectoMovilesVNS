import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/login_page.dart';
import 'package:proyecto_vsn/Screens/profile.dart';
import 'package:proyecto_vsn/Screens/welcome.dart';

bool isSwitched = false;

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text("Valeria Ramirez"),
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
            color: Colors.blueGrey,
            /*
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/imagen3.jpeg"
                ),
                fit: BoxFit.cover,
              )
              */
          ),
        ),
        ListTile(
          leading: Icon(Icons.app_settings_alt),
          title: Text("Configuracion"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ProfileScreen(), // Reemplaza 'Configuraciones' con el nombre correcto de tu página.
            ));
          },
        ),
        ListTile(
          leading: Icon(Icons.currency_exchange),
          title: Text("Divisa"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.lightbulb_sharp),
          title: Text("Modo Oscuro"),
          trailing: Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                // Aquí puedes cambiar el tema entre oscuro y claro
                //MyApp.setBrightness(isSwitched ? Brightness.dark : Brightness.light);
              });
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Cerrar Sesion"),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Welcome(), // Replace SecondScreen with the screen you navigate to.
                ));
          },
        ),
      ],
    ));
  }
}
