import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/ahorro_item.dart';
import 'package:proyecto_vsn/Screens/nueva_meta.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

class Ahorro {
  final String id;
  final String nombre;
  final double meta;
  final String origen;
  final DateTime fecha;
  final double progreso;
  final String IdUsuario;

  Ahorro({
    required this.id,
    required this.nombre,
    required this.meta,
    required this.origen,
    required this.fecha,
    required this.progreso,
    required this.IdUsuario,
  });

  factory Ahorro.fromSnapshot(DocumentSnapshot snapshot) {
    try {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      print('Data from Firestore: $data');
      return Ahorro(
        id: snapshot.id,
        fecha: data['Fecha'].toDate() ?? DateTime.now(),
        IdUsuario: data['IdUsuario'].toString() ?? '',
        meta: (data['Monto'] ?? 0.0).toDouble(),
        nombre: data['Nombre'] ?? '',
        origen: data['Origen'] ?? '',
        progreso: data['Progreso'] ?? '',
      );
    } catch (e, stackTrace) {
      print('Error creating Egreso from snapshot: $e');
      print('Stack trace: $stackTrace');
      return Ahorro(
        id: '',
        fecha: DateTime.now(),
        IdUsuario: "1",
        origen: '',
        meta: 0.0,
        nombre: '',
        progreso: 4.0,
      );
    }
  }
}

class Ahorros extends StatefulWidget {
  Ahorros({super.key});

  @override
  State<Ahorros> createState() => _AhorrosState();
}

class _AhorrosState extends State<Ahorros> {
  late List<Ahorro> items;
  double total = 0;

  Future<List<Ahorro>> loadFirestoreData() async {
    // Obtener el usuario actualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // El usuario no está autenticado, manejar según tus necesidades
      return [];
    }

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Ahorros')
          .where('IdUsuario', isEqualTo: user.uid) // Filtrar por userId
          .get();

      List<Ahorro> lista = querySnapshot.docs
          .map((DocumentSnapshot document) => Ahorro.fromSnapshot(document))
          .toList();

      return lista;
    } catch (e) {
      print('Error loading data from Firebase: $e');
      return []; // o manejar el error según tus necesidades
    }
  }

  @override
  void initState() {
    super.initState();
    loadFirestoreData().then((loadedData) {
      setState(() {
        items = loadedData;
        total = items.map((item) => item.progreso).reduce((a, b) => a + b);
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
    return FutureBuilder<List<Ahorro>>(
      future: loadFirestoreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CupertinoActivityIndicator(
            animating: true,
            radius: 30.0, // Ajusta el tamaño del indicador
          ));
          ;
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          items = snapshot.data!;
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
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
                                'Tu ahorro',
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      themeState.themeData.colorScheme.shadow,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: TextButton(
                                onPressed: () async {
                                  // Navigate to the second screen
                                  var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NuevaMeta()),
                                  );
                                  if (result != null) {
                                    setState(() {
                                      items.insert(0, result);
                                      total += result.progreso;
                                      print('items:');
                                      print(items);
                                    });
                                  }
                                },
                                child: Text('+ Nueva meta',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                        Text('Tu ahorro',
                            style: TextStyle(
                              fontSize: 17,
                              color: themeState.themeData.colorScheme.shadow,
                            )),
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
                                    color: themeState
                                        .themeData.colorScheme.shadow),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: Text('MXM',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color:
                                        themeState.themeData.colorScheme.shadow,
                                  )),
                            )
                          ],
                        ),
                        Text(
                            '${getMonthName(DateTime.now().month)} ${DateTime.now().year}',
                            style: TextStyle(
                              color: themeState.themeData.colorScheme.shadow,
                            ))
                      ]),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return AhorroItem(data: items[index]);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
