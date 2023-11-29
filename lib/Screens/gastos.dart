import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/egreso_item.dart';
import 'package:proyecto_vsn/Screens/nuevo_egreso.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

class Egreso {
  final String Categoria;
  final DateTime Fecha;
  final String Frecuencia;
  final String IdUsuario;
  final String MedioPago;
  final double Monto;
  final String Nombre;

  Egreso({
    required this.Categoria,
    required this.Fecha,
    required this.Frecuencia,
    required this.IdUsuario,
    required this.MedioPago,
    required this.Monto,
    required this.Nombre,
  });

  factory Egreso.fromSnapshot(DocumentSnapshot snapshot) {
    try {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      print('Data from Firestore: $data');
      return Egreso(
        Categoria: data['Categoria'] ?? '',
        Fecha: data['Fecha'].toDate() ?? DateTime.now(),
        Frecuencia: data['Frecuencia'] ?? '',
        IdUsuario: data['IdUsuario'].toString() ?? '',
        MedioPago: data['MedioPago'] ?? '',
        Monto: (data['Monto'] ?? 0.0).toDouble(),
        Nombre: data['Nombre'] ?? '',
      );
    } catch (e, stackTrace) {
      print('Error creating Egreso from snapshot: $e');
      print('Stack trace: $stackTrace');
      return Egreso(
        Categoria: 'Error',
        Fecha: DateTime.now(),
        Frecuencia: '',
        IdUsuario: "1",
        MedioPago: '',
        Monto: 0.0,
        Nombre: '',
      );
    }
  }
}

class Egresos extends StatefulWidget {
  const Egresos({super.key});

  @override
  State<Egresos> createState() => _EgresosState();
}

class _EgresosState extends State<Egresos> {
  late List<Egreso> items;
  double total = 0;

  Future<List<Egreso>> loadFirestoreData() async {
    // Obtener el usuario actualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // El usuario no está autenticado, manejar según tus necesidades
      return [];
    }

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Egresos')
          .where('IdUsuario', isEqualTo: user.uid) // Filtrar por userId
          .get();

      List<Egreso> lista = querySnapshot.docs
          .map((DocumentSnapshot document) => Egreso.fromSnapshot(document))
          .toList();

      return lista;
    } catch (e) {
      print('Error loading data from Firebase: $e');
      return []; // o manejar el error según tus necesidades
    }
  }

  String formatDate(Timestamp timestamp) {
    // Formatear el Timestamp a un formato más legible
    DateTime dateTime = timestamp.toDate();
    return DateFormat('yyyy-MM-dd').format(dateTime);
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
  Widget build(BuildContext context) {
    return FutureBuilder<List<Egreso>>(
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
                              'Tus egresos',
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
                                        builder: (context) => NuevoEgreso()));
                                if (result != null) {
                                  setState(() {
                                    items.add(result);
                                    print('items:');
                                    print(items);
                                  });
                                }
                              },
                              child: Text('+ Nuevo egreso',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          )
                        ],
                      ),
                      Text('Tus egresos',
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
                      print(
                          'Item data: ${items[index].Nombre}, ${items[index].Fecha}, ${items[index].Monto}');
                      return EgresoItem(
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
