import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/ingreso_item.dart';
import 'package:proyecto_vsn/Screens/nuevo_ingreso.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

class Ingreso {
  final String Categoria;
  final DateTime Fecha;
  final String Frecuencia;
  final String IdUsuario;
  final double Monto;
  final String Nombre;
  final String TipoIngrso;

  Ingreso({
    required this.Categoria,
    required this.Fecha,
    required this.Frecuencia,
    required this.IdUsuario,
    required this.Monto,
    required this.Nombre,
    required this.TipoIngrso,
  });

  factory Ingreso.fromSnapshot(DocumentSnapshot snapshot) {
    try {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      print('Data from Firestore: $data');
      return Ingreso(
          Categoria: data['Categoria'] ?? '',
          Fecha: data['Fecha'].toDate() ?? DateTime.now(),
          Frecuencia: data['Frecuencia'] ?? '',
          IdUsuario: data['IdUsuario'].toString() ?? '',
          Monto: (data['Monto'] ?? 0.0).toDouble(),
          Nombre: data['Nombre'] ?? '',
          TipoIngrso: data['TipoIngreso'] ?? '');
    } catch (e, stackTrace) {
      print('Error creating Egreso from snapshot: $e');
      print('Stack trace: $stackTrace');
      return Ingreso(
        Categoria: 'Error',
        Fecha: DateTime.now(),
        Frecuencia: '',
        IdUsuario: '1',
        Monto: 0.0,
        Nombre: '',
        TipoIngrso: '',
      );
    }
  }
}

class Ingresos extends StatefulWidget {
  const Ingresos({super.key});

  @override
  State<Ingresos> createState() => _IngresosState();
}

class _IngresosState extends State<Ingresos> {
  late List<Ingreso> items;
  double total = 0;

  Future<List<Ingreso>> loadFirestoreData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // El usuario no está autenticado, manejar según tus necesidades
      return [];
    }

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Ingresos')
          .where('IdUsuario', isEqualTo: user.uid)
          .get();
      List<Ingreso> lista = querySnapshot.docs
          .map((DocumentSnapshot document) => Ingreso.fromSnapshot(document))
          .toList();

      return lista;
    } catch (e) {
      print('Error loading data from Firebase: $e');
      return [];
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "Invalid Month";
    }
  }

  @override
  void initState() {
    super.initState();
    loadFirestoreData().then((loadedData) {
      setState(() {
        items = loadedData;
        total = items.map((item) => item.Monto).reduce((a, b) => a + b);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ingreso>>(
      future: loadFirestoreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          items = snapshot.data!;
          return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
            List<String> categorias = [
              'Salario',
              'Aguinaldo',
              'Bonos',
              'Emprendimiento',
              'Otros'
            ];
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: themeState.themeData.colorScheme.primary,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Tus ingresos',
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      themeState.themeData.colorScheme.shadow),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: TextButton(
                              onPressed: () async {
                                var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NuevoIngreso()));
                                if (result != null) {
                                  setState(() {
                                    items.add(result);
                                    print('items:');
                                    print(items);
                                  });
                                }
                              },
                              child: Text('+ Nuevo ingreso',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          )
                        ],
                      ),
                      Text('Tus ingresos',
                          style: TextStyle(
                              fontSize: 17,
                              color: themeState.themeData.colorScheme.shadow)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "\$${total.toString()}",
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      themeState.themeData.colorScheme.shadow),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 13),
                            child: Text('MXM',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: themeState
                                        .themeData.colorScheme.shadow)),
                          )
                        ],
                      ),
                      Text(
                          '${getMonthName(DateTime.now().month)} ${DateTime.now().year}',
                          style: TextStyle(
                              color: themeState.themeData.colorScheme.shadow))
                    ]),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return IngresoItem(
                        titulo: items[index].Nombre,
                        subtitulo1: items[index].Nombre,
                        fecha: items[index]
                            .Fecha, // Reemplaza con el valor correcto
                        precio: items[index]
                            .Monto, // Reemplaza con el valor correcto
                      );
                    },
                  ),
                ],
              ),
            );
          });
        }
      },
    );
  }
}

Widget categoriaChip(String titulo, Color chipColor) {
  return Chip(
    label: Text(titulo),
    backgroundColor: chipColor,
  );
}
