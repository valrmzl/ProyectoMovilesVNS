import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/gastos.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';
import 'package:proyecto_vsn/firebase_options.dart';

//instalamos la coleccion a firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NuevoEgreso extends StatefulWidget {
  const NuevoEgreso({Key? key});

  @override
  State<NuevoEgreso> createState() => _NuevoEgresoState();
}

class _NuevoEgresoState extends State<NuevoEgreso> {
  final montoEgreso = TextEditingController();
  final nombre = TextEditingController();
  DateTime? fechaSeleccionada;

  String categoriaSeleccionada = 'Comida';
  String recibidoSeleccionado = 'Efectivo';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null && picked != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = picked;
      });
    }
  }

  void _guardarEgresoFireBase(Map<String, dynamic> data) async {
    try {
      // Obtener el usuario actualmente autenticado
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Usuario autenticado

        CollectionReference egresosCollection =
            FirebaseFirestore.instance.collection("Egresos");

        int monto = int.tryParse(montoEgreso.text) ?? 0;

        data['IdUsuario'] = user.uid;

        await egresosCollection.add(data);
        print("Egreso agregado exitosamente");
      } else {
        // Usuario no autenticado
        print("Error: Usuario no autenticado al intentar agregar el egreso");
      }
    } catch (e) {
      print("Error al agregar el egreso: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> categorias = [
      'Comida',
      'Cuidado personal',
      'Diversion',
      'Educación',
      'Ejercicio',
      'Hogar',
      'Regalos',
      'Renta',
      'Salud',
      'Servicios',
      'Suscripciones',
      'Transporte',
      'Viajes',
      'Otros'
    ];

   

    List<String> recibido = ['Efectivo', 'Crédito', 'Débito'];

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Hola otra vez :)",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                            makeInput(
                                label: "¿Cuál es el monto de tu gasto? ",
                                controller: montoEgreso),
                            makeInput(
                                label: "¿Qué nombre le quieres dar? ",
                                controller: nombre),
                            makeDropdown(
                                label: "¿Con que medio hiciste este pago?",
                                options: recibido,
                                selectedValue: recibidoSeleccionado,
                                onValueChanged: (newValue) {
                                  recibidoSeleccionado = newValue!;
                                }),
                            makeDropdown(
                                label: "Categoría de tu gasto",
                                options: categorias,
                                selectedValue: categoriaSeleccionada,
                                onValueChanged: (newValue) {
                                  categoriaSeleccionada = newValue!;
                                }),
                            TextFormField(
                              onTap: () async {
                                await _selectDate(context);
                                setState(() {});
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                text: fechaSeleccionada != null
                                    ? "${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year}"
                                    : "Selecciona una fecha",
                              ),
                              decoration: InputDecoration(
                                labelText: "Fecha de tu ingreso",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              int monto = int.tryParse(montoEgreso.text) ?? 0;

                              Map<String, dynamic> data = {
                                'Monto': monto,
                                'Fecha': fechaSeleccionada != null
                                    ? Timestamp.fromDate(fechaSeleccionada!)
                                    : Timestamp.fromDate(DateTime.now()),
                                'Nombre': nombre.text,
                                "Categoria": categoriaSeleccionada,
                                'MedioPago': recibidoSeleccionado,
                              };
                              Navigator.pop(
                                  context,
                                  Egreso(
                                      Categoria: categoriaSeleccionada,
                                      Fecha: fechaSeleccionada != null
                                          ? fechaSeleccionada!
                                          : DateTime.now(),
                                      IdUsuario: '',
                                      Monto: monto.toDouble(),
                                      Nombre: nombre.text,
                                      MedioPago: recibidoSeleccionado));
                              _guardarEgresoFireBase(data);
                            },
                            color: themeState.themeData.colorScheme.secondary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Agregar gasto",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget makeInput(
      {String? label,
      bool obscureText = false,
      String? value,
      TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label ?? '',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  // Widget makeDropdown(
  //     {String? label, List<String> options = const [], String? selectedValue}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         label ?? '',
  //         style: TextStyle(
  //             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
  //       ),
  //       SizedBox(height: 5),
  //       Container(
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.grey),
  //           borderRadius: BorderRadius.circular(5),
  //         ),
  //         child: DropdownButtonFormField<String>(
  //           value: selectedValue,
  //           onChanged: (newValue) {
  //             setState(() {
  //               selectedValue = newValue;
  //             });
  //           },
  //           items: options.map((option) {
  //             return DropdownMenuItem<String>(
  //               value: option,
  //               child: Text(option),
  //             );
  //           }).toList(),
  //           decoration: InputDecoration(
  //             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  //             enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(color: Colors.transparent),
  //             ),
  //             border: OutlineInputBorder(
  //               borderSide: BorderSide(color: Colors.transparent),
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(height: 10),
  //     ],
  //   );
  // }
}

Widget makeDropdown({
  String? label,
  List<String> options = const [],
  String? selectedValue,
  required void Function(String?) onValueChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label ?? '',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          onChanged: (newValue) {
            // Invoke the callback provided by the parent
            onValueChanged(newValue);
          },
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
