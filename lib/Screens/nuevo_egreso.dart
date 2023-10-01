import 'package:flutter/material.dart';

class NuevoEgreso extends StatefulWidget {
  const NuevoEgreso({Key? key});

  @override
  State<NuevoEgreso> createState() => _NuevoEgresoState();
}

class _NuevoEgresoState extends State<NuevoEgreso> {
  DateTime? fechaSeleccionada; // Variable para almacenar la fecha seleccionada.

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
      'Transporte'
      'Viajes',
      'Otros'
    ];
    String categoriaSeleccionada = 'Comida';

    List<String> frecuencia = [
      'Sin frecuencia',
      'Semanal',
      'Quincenal',
      'Mensual'
    ];
    String frecuenciaSeleccionada = 'Sin frecuencia';

    List<String> recibido = ['Efectivo', 'Crédito', 'Débito'];
    String recibidoSeleccionado = 'Efectivo';

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
                            label: "¿Cuál es el monto de tu gasto? "),
                        makeInput(label: "¿Qué nombre le quieres dar? "),
                        makeDropdown(
                            label: "¿Con que medio hiciste este pago?",
                            options: recibido,
                            selectedValue: recibidoSeleccionado),
                        makeDropdown(
                            label: "Categoría de tu gasto",
                            options: categorias,
                            selectedValue: categoriaSeleccionada),
                        makeDropdown(
                            label: "¿Cada cuanto te llega este ingreso?",
                            options: frecuencia,
                            selectedValue: frecuenciaSeleccionada),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context); // Abre el selector de fecha.
                          },
                          child: makeInput(
                            label: "Fecha de tu ingreso",
                            value: fechaSeleccionada != null
                                ? "${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year}"
                                : "Selecciona una fecha",
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
                          
                        },
                        color: Colors.greenAccent,
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
  }

  Widget makeInput(
      {String? label, bool obscureText = false, String? value}) {
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
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget makeDropdown(
      {String? label, List<String> options = const [], String? selectedValue}) {
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
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
