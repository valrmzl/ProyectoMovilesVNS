import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/ahorro_detalle.dart';

import 'ahorros.dart';

class AhorroItem extends StatefulWidget {
  final Ahorro data;

  const AhorroItem({Key? key, required this.data}) : super(key: key);

  @override
  State<AhorroItem> createState() => _AhorroItemState();
}

class _AhorroItemState extends State<AhorroItem> {
  List<String> monthsOfYear = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AhorroDetalle(data: widget.data)));
      },
      child: Card(
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
                            '${widget.data.fecha.day} ${monthsOfYear[widget.data.fecha.month]} ${widget.data.fecha.year}')
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text("\$${widget.data.meta}",
                            style: TextStyle(fontWeight: FontWeight.bold))
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
  }
}
