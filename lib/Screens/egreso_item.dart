import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

class EgresoItem extends StatelessWidget {
  final String titulo;
  final String subtitulo1;
  final DateTime fecha;
  final double precio;

  EgresoItem({
    required this.titulo,
    required this.subtitulo1,
    required this.fecha,
    required this.precio,
  }) {
    print('subtitulo' + this.precio.toString());
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
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Card(
        color: themeState.themeData.colorScheme.surfaceVariant,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                //leading: Icon(Icons.local_restaurant),
                title: Text(titulo),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            categoriaChip("Salario",
                                const Color.fromARGB(255, 229, 132, 164)),
                            SizedBox(width: 8), // Espacio entre chips
                            categoriaChip("Transferencia",
                                Color.fromARGB(255, 226, 228, 136)),
                          ],
                        ),
                        Text(
                            '${fecha.day} ${getMonthName(fecha.month)} ${fecha.year}'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                        ),
                        Text("\$$precio",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget categoriaChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color,
    );
  }
}
