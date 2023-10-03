import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/egreso_item.dart';
import 'package:proyecto_vsn/Screens/ingreso_item.dart';
// ignore: unused_import
import 'package:proyecto_vsn/Screens/nuevo_egreso.dart';



class Egresos extends StatefulWidget {
  const Egresos({super.key});

  @override
  State<Egresos> createState() => _EgresosState();
}

class _EgresosState extends State<Egresos> {
  @override
  Widget build(BuildContext context) {
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
            color: Color.fromARGB(255, 184, 243, 223),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Tus Egresos',
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
              Text('Tus Egresos',
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
          Container(
  height: MediaQuery.of(context).size.height * 1,
  child: ListView.separated(
    itemCount: categorias.length+8,
    separatorBuilder: (context, index) {
      return Divider();
    },
    itemBuilder: (context, index) {
      return EgresoItem(
        titulo: "elotes",
        subtitulo1: "comida",
        fecha: "01/10/23",// Reemplaza con el valor correcto
        precio: 011023, // Reemplaza con el valor correcto
      );
    },
  ),
)


            
            
          
          
        ],
      ),
    );
  }
}

Widget categoriaChip(String titulo, Color chipColor ){
  return Chip(
    label: Text(titulo),
    backgroundColor: chipColor,
  );
}
