import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Datos de ejemplo para el perfil del usuario
  String nombre = "John Doe";
  String correo = "johndoe@example.com";
  String pais = "Estados Unidos";
  String imagenPerfilURL =
      "https://example.com/profile.jpg";

  // Controladores para los campos editables
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController paisController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nombreController.text = nombre;
    correoController.text = correo;
    paisController.text = pais;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Dos pestañas: Ver y Editar
      child: Scaffold(
        appBar: AppBar(
          title: Text("Perfil de Usuario"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Ver"),
              Tab(text: "Editar"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Pestaña "Ver"
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(imagenPerfilURL),
                  ),
                  Card(
                    color: Colors.green,
                    child: ListTile(
                      title: Text(
                        "Nombre",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        nombre,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.green,
                    child: ListTile(
                      title: Text(
                        "Correo",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        correo,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.green,
                    child: ListTile(
                      title: Text(
                        "País",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        pais,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Pestaña "Editar"
            SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(imagenPerfilURL),
                  ),
                  Card(
                    child: ListTile(
                      title: TextField(
                        controller: nombreController,
                        decoration: InputDecoration(
                          labelText: "Nombre",
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: TextField(
                        controller: correoController,
                        decoration: InputDecoration(
                          labelText: "Correo",
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: TextField(
                        controller: paisController,
                        decoration: InputDecoration(
                          labelText: "País",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Actualizar los datos del perfil con los valores en los controladores
                      setState(() {
                        nombre = nombreController.text;
                        correo = correoController.text;
                        pais = paisController.text;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Perfil actualizado")),
                      );
                    },
                    child: Text("Guardar Cambios"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
