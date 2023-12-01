import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

class EgresoItem extends StatelessWidget {
  final String titulo;
  final String subtitulo1;
  final DateTime fecha;
  final double precio;
  final String categoria;
  final String tipoEgreso;

  EgresoItem(
      {required this.titulo,
      required this.subtitulo1,
      required this.fecha,
      required this.precio,
      required this.categoria,
      required this.tipoEgreso}) {
    print('subtitulo' + this.precio.toString());
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
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
                            categoriaChip(categoria,
                                const Color.fromARGB(255, 229, 132, 164)),
                            SizedBox(width: 8), // Espacio entre chips
                            categoriaChip(
                                tipoEgreso,
                                tipoEgreso == 'Efectivo'
                                    ? Color.fromARGB(255, 146, 132, 229)
                                    : tipoEgreso == 'Crédito'
                                        ? Color.fromARGB(255, 226, 228, 136)
                                        : Color.fromARGB(255, 218, 132, 42)),
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
