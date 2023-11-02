import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/ahorro_item.dart';
import 'package:proyecto_vsn/Screens/nueva_meta.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

class Ahorro {
  final String nombre;
  final double meta;
  final String origen;
  final DateTime fecha;
  final double progreso;

  Ahorro({
    required this.nombre,
    required this.meta,
    required this.origen,
    required this.fecha,
    required this.progreso,
  });

  factory Ahorro.fromJson(Map<String, dynamic> json) {
    return Ahorro(
      nombre: json['nombre'] as String,
      meta: json['meta'].toDouble() as double,
      origen: json['origen'] as String,
      fecha: DateTime.parse(json['fecha']) as DateTime,
      progreso: json['progreso'].toDouble() as double,
    );
  }
}

class Ahorros extends StatefulWidget {
  Ahorros({super.key});

  @override
  State<Ahorros> createState() => _AhorrosState();
}

class _AhorrosState extends State<Ahorros> {
  late List<Ahorro> items;

  Future<List<Ahorro>> loadJsonData() async {
    final jsonString = await rootBundle.loadString('lib/data/ahorro.json');
    final jsonData = json.decode(jsonString);
    List<Ahorro> lista = [];
    for (int i = 0; i < jsonData.length; i++) {
      lista.add(Ahorro.fromJson(jsonData[i]));
    }
    return lista;
  }

  @override
  void initState() {
    super.initState();
    loadJsonData().then((loadedData) {
      setState(() {
        items = loadedData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ahorro>>(
      future: loadJsonData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator.
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
                                onPressed: () {
                                  // Navigate to the second screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NuevaMeta()),
                                  );
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
                                r"$0.03",
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
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
                        Text('Septiembre 2023',
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
