import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/calendar.dart';
import 'package:proyecto_vsn/Screens/gastos.dart';
import 'package:proyecto_vsn/Screens/ingresos.dart';
import 'package:proyecto_vsn/data/list_dummy.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  DateTime? selectedDay;
  late List<Ingreso> ingresos;
  late List<Egreso> egresos;
  User? currentUser;

  double total = 0;
  double total_ingresos = 0;
  double total_egresos = 0;
  List<dynamic> todos = [];

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

  Future<List<Ingreso>> loadJsonDataIngreso() async {
    final jsonString = await rootBundle.loadString('lib/data/ingreso.json');
    final jsonData = json.decode(jsonString);
    List<Ingreso> lista = [];
    for (int i = 0; i < jsonData.length; i++) {
      //lista.add(Ingreso.fromJson(jsonData[i]));
    }
    return lista;
  }

  Future<List<Egreso>> loadJsonDataEgreso() async {
    final jsonString = await rootBundle.loadString('lib/data/egreso.json');
    final jsonData = json.decode(jsonString);
    List<Egreso> lista = [];
    for (int i = 0; i < jsonData.length; i++) {
      //lista.add(Egreso.fromJson(jsonData[i]));
    }
    return lista;
  }

  Future<List<Ingreso>> loadFirebaseDataIngreso() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // El usuario no está autenticado, manejar según tus necesidades
      return [];
    }
    String userId = user.uid;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Ingresos')
          .where('IdUsuario', isEqualTo: userId) // Filtrar por IdUsuario
          .get();

      List<Ingreso> lista = querySnapshot.docs
          .map((DocumentSnapshot document) => Ingreso.fromSnapshot(document))
          .toList();

      return lista;
    } catch (e) {
      print('Error loading ingresos from Firebase: $e');
      return []; // o manejar el error según tus necesidades
    }
  }

  Future<List<Egreso>> loadFirebaseDataEgreso() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // El usuario no está autenticado, manejar según tus necesidades
      return [];
    }
    String userId = user.uid;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Egresos')
          .where('IdUsuario', isEqualTo: userId) // Filtrar por IdUsuario
          .get();

      List<Egreso> lista = querySnapshot.docs
          .map((DocumentSnapshot document) => Egreso.fromSnapshot(document))
          .toList();

      return lista;
    } catch (e) {
      print('Error loading egresos from Firebase: $e');
      return []; // o manejar el error según tus necesidades
    }
  }

  Future<int> loadJsonDataUser() async {
    final jsonString = await rootBundle.loadString('lib/data/user.json');
    final jsonData = json.decode(jsonString);
    var lista = 1;
    return lista;
  }

  Future<dynamic> getData() async {
    // Obtener el usuario actualmente autenticado
    currentUser = await FirebaseAuth.instance.currentUser;
    egresos = await loadFirebaseDataEgreso();
    total_egresos = egresos.map((item) => item.Monto).reduce((a, b) => a + b);
    ingresos = await loadFirebaseDataIngreso();
    total_ingresos = ingresos.map((item) => item.Monto).reduce((a, b) => a + b);
    total = total_ingresos - total_egresos;
    todos = todos + ingresos + egresos;
    todos.sort((a, b) => a.Fecha.compareTo(b.Fecha));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<dynamic>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While data is being fetched, display a loading indicator or placeholder
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle errors
          return Text('Error: ${snapshot.error}');
        } else {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: 280, child: _head(context)),
                ),
                SliverToBoxAdapter(child: Calendar()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Historial de transacciones",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                                color: Colors.black)),
                        Text("Ver todo",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Icon(
                            Icons.credit_score_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                        title: Text(todos[index].Nombre,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            )),
                        subtitle: Text(
                            '${todos[index].Fecha.day} ${getMonthName(todos[index].Fecha.month)} ${todos[index].Fecha.year}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            )),
                        trailing: Text(
                          todos[index].Monto.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: todos[index].runtimeType == Ingreso
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      );
                    },
                    childCount: todos.length,
                  ),
                ),
              ],
            ),
          );
        }
      },
    ));
  }

  Widget _head(context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: 140,
                  decoration: BoxDecoration(
                    color: themeState.themeData.colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.85,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Buenas tardes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black)),
                            Text(currentUser?.displayName ?? 'null',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.black)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 90,
              left: MediaQuery.of(context).size.width * 0.1,
              child: Container(
                height: 170,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(47, 125, 121, 0.3),
                      offset: Offset(0, 6),
                      blurRadius: 12,
                      spreadRadius: 6,
                    )
                  ],
                  color: Color.fromARGB(255, 47, 125, 121),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Balance Total",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          Icon(Icons.more_horiz, color: Colors.white)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: [
                          Text('\$$total',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor:
                                    Color.fromARGB(255, 85, 145, 141),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                  size: 19,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text("Ingresos",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white)),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundColor:
                                    Color.fromARGB(255, 85, 145, 141),
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white,
                                  size: 19,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Egresos",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$$total_ingresos',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.white)),
                          Text('\$$total_egresos',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
