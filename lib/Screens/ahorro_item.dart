import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/ahorro_detalle.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

import 'ahorros.dart';

class AhorroItem extends StatefulWidget {
  final Ahorro data;

  const AhorroItem({Key? key, required this.data}) : super(key: key);

  @override
  State<AhorroItem> createState() => _AhorroItemState();
}

class _AhorroItemState extends State<AhorroItem> {
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
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AhorroDetalle(data: widget.data)));
        },
        child: Card(
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
                  title: Text(widget.data.nombre),
                  subtitle: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(widget.data.origen),
                          ),
                          Text(
                            '${widget.data.fecha.day} ${getMonthName(widget.data.fecha.month)} ${widget.data.fecha.year}',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          height: 8,
                          child: LinearProgressIndicator(
                            value: widget.data.progreso / widget.data.meta,
                            backgroundColor: Colors
                                .grey.shade100, // Color de fondo de la barra
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 182, 179,
                                    196)), // Color de la parte de progreso
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "\$${widget.data.progreso}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Text("\$${widget.data.meta}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
