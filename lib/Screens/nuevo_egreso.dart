import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';
import 'package:proyecto_vsn/firebase_options.dart';

//instalamos la coleccion a firebase
import 'package:cloud_firestore/cloud_firestore.dart';

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
  String frecuenciaSeleccionada = 'Sin frecuencia';
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

  void _guardarEgresoFireBase() async {
    try {
      CollectionReference testCollection = FirebaseFirestore.instance.collection("Egresos");

      DateTime now = DateTime.now();
      // Convierte el valor del campo 'Monto' a un entero
    int monto = int.tryParse(montoEgreso.text) ?? 0;



      Map<String, dynamic> data = {
        'Categoria': categoriaSeleccionada,
        'Fecha': fechaSeleccionada != null ? Timestamp.fromDate(fechaSeleccionada!) : null,
        'Frecuencia': frecuenciaSeleccionada,
        'IdUsuario': 1,
        'MedioPago': recibidoSeleccionado,
        'Monto': monto,
        'Nombre': nombre.text,
      };

      await testCollection.add(data);
      print("Egreso agregado exitosamente");
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

    List<String> frecuencia = [
      'Sin frecuencia',
      'Semanal',
      'Quincenal',
      'Mensual',
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
                Navigator.pop(context);
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
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                            makeInput(label: "¿Cuál es el monto de tu gasto? ", controller: montoEgreso),
                            makeInput(label: "¿Qué nombre le quieres dar? ", controller: nombre),
                            

                            
                          
                            
                            makeDropdown(label: "¿Con que medio hiciste este pago?", options: recibido, selectedValue: recibidoSeleccionado),
                            
                            makeDropdown(label: "Categoría de tu gasto", options: categorias, selectedValue: categoriaSeleccionada),
                            makeDropdown(label: "¿Cada cuanto te llega este ingreso?", options: frecuencia, selectedValue: frecuenciaSeleccionada),
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
                              Navigator.pop(context);
                              _guardarEgresoFireBase();
                            },
                            color: themeState.themeData.colorScheme.secondary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Agregar gasto",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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

  Widget makeInput({String? label, bool obscureText = false, String? value, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label ?? '',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
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

Widget makeDropdown({String? label, List<String> options = const [], String? selectedValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label ?? '',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: (newValue) {
              setState(() {
                selectedValue = newValue;
              });
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
        SizedBox(height: 10),
      ],
    );
  }

}
