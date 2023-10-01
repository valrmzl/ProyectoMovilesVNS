import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/ahorro_item.dart';
import 'package:proyecto_vsn/Screens/nuevo_egreso.dart';

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
}

class Gastos extends StatelessWidget {
  const Gastos({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 141, 240, 223),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Tus Gastos',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> NuevoEgreso()));
                      },
                      child: Text('+ Nuevo egreso',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
              Text('Tu ahorro',
                  style: TextStyle(fontSize: 17, color: Colors.grey.shade800)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      r"$0.03",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: Text('MXM',
                        style: TextStyle(
                            fontSize: 17, color: Colors.grey.shade800)),
                  )
                ],
              ),
              Text('Septiembre 2023',
                  style: TextStyle(color: Colors.grey.shade800))
            ]),
          ),
          
        ],
      ),
    );
  }
}
