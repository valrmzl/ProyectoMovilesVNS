import 'package:flutter/material.dart';

class IngresoItem extends StatelessWidget {
  final String titulo;
  final String subtitulo1;
  final String fecha;
  final double precio;

  IngresoItem({
    required this.titulo,
    required this.subtitulo1,
    required this.fecha,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                          categoriaChip("Salario", const Color.fromARGB(255, 229, 132, 164)),
                          SizedBox(width: 8), // Espacio entre chips
                          categoriaChip("Transferencia", Color.fromARGB(255, 226, 228, 136)),
                          
                        ],
                      ),
                      Text(fecha),
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
  }

  Widget categoriaChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color,
    );
  }
}
