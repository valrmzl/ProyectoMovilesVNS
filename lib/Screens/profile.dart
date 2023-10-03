import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:proyecto_vsn/Screens/home_page.dart';
import 'package:proyecto_vsn/Screens/login_page.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variables para almacenar los datos del usuario
  String _name = 'Valeria Ramirez';
  String _email = 'val@gmail.com';
  String _phoneNumber = '3321860328';

  // Controladores para los campos de edición
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  // Variables para el menú desplegable de divisas
  List<String> _currencies = ['USD', 'EUR', 'JPY', 'MX'];
  String _selectedCurrency = 'MX';

  // Método para mostrar el cuadro de diálogo de edición
  Future<void> _showEditDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo'),
              ),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Número'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Actualizar los datos del usuario con los valores de los controladores
                  _name = _nameController.text;
                  _email = _emailController.text;
                  _phoneNumber = _phoneNumberController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(98, 180, 123, 1),
                Color.fromARGB(255, 184, 243, 223),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromRGBO(184, 243, 223, 0.5),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: _showEditDialog,
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(0, 228, 21, 21),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'MI PERFIL',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: height * 0.6,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: MediaQuery.of(context).size.width * 0.5,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      _name,
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 37,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Correo',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              _email,
                                              style: TextStyle(
                                                color: Color.fromRGBO(39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 8,
                                          ),
                                          child: Container(
                                            height: 50,
                                            width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Número',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              _phoneNumber,
                                              style: TextStyle(
                                                color: Color.fromRGBO(39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    
                                    // Agregar el segundo Container con el menú desplegable
                                    Container(
                                      height: 83,
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Divisa',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontFamily: 'Nunito',
                                              fontSize: 25,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          DropdownButton<String?>(
                                            value: _selectedCurrency,
                                            items: _currencies.map((String currency) {
                                              return DropdownMenuItem<String?>(
                                                value: currency,
                                                child: Text(
                                                  currency,
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(39, 105, 171, 1),
                                                    fontFamily: 'Nunito',
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedCurrency = newValue ?? '';
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.width*0.001,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/val.png',
                                    width: innerWidth * 0.40,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}