import 'package:flutter/material.dart';


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
                child: Image.network("https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80",
                width: 90,
                height: 90,
                fit: BoxFit.cover,),
                 ),
            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              /*
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1695015316959-dba54e216898?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8OHx6dTdpdUZNNmE3OHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60"
                ),
                fit: BoxFit.cover,
              )
              */
            ),

             )
        ,
        ListTile(
          leading: Icon(Icons.app_settings_alt),
          title: Text("Configuracion"),
          onTap: (){},

        ),
        ListTile(
          leading: Icon(Icons.currency_exchange),
          title: Text("Divisa"),
          onTap: (){},
          
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
          onTap: (){},
          
        ),
        ],
      )
      
    );
  }
}