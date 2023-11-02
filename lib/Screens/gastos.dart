import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/egreso_item.dart';
import 'package:proyecto_vsn/Screens/nuevo_egreso.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

class Egreso {
  final String titulo;
  final String subtitulo1;
  final String fecha;
  final double precio;

  Egreso(
      {required this.titulo,
      required this.subtitulo1,
      required this.fecha,
      required this.precio});

  factory Egreso.fromJson(Map<String, dynamic> json) {
    return Egreso(
      titulo: json['titulo'] as String,
      subtitulo1: json['subtitulo1'] as String,
      fecha: json['fecha'] as String,
      precio: json['precio'].toDouble() as double,
    );
  }
}

class Egresos extends StatefulWidget {
  const Egresos({super.key});

  @override
  State<Egresos> createState() => _EgresosState();
}

class _EgresosState extends State<Egresos> {
  late List<Egreso> items;

  Future<List<Egreso>> loadJsonData() async {
    final jsonString = await rootBundle.loadString('lib/data/egreso.json');
    final jsonData = json.decode(jsonString);
    List<Egreso> lista = [];
    for (int i = 0; i < jsonData.length; i++) {
      lista.add(Egreso.fromJson(jsonData[i]));
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
    return FutureBuilder<List<Egreso>>(
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NuevoEgreso()));
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
                              r"$0.03",
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
                      Text('Septiembre 2023',
                          style: TextStyle(
                              color: themeState.themeData.colorScheme.shadow))
                    ]),
                  ),
                  Container(
                    color: themeState.themeData.colorScheme.onSurfaceVariant,
                    height: MediaQuery.of(context).size.height * 1,
                    child: ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemBuilder: (context, index) {
                        return EgresoItem(
                          titulo: items[index].titulo,
                          subtitulo1: items[index].subtitulo1,
                          fecha: items[index]
                              .fecha, // Reemplaza con el valor correcto
                          precio: items[index]
                              .precio, // Reemplaza con el valor correcto
                        );
                      },
                    ),
                  )
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
