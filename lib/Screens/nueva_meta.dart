import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/ahorros.dart';
import 'package:proyecto_vsn/firebase_options.dart';

//instalamos la coleccion a firebase
import 'package:cloud_firestore/cloud_firestore.dart';

class NuevaMeta extends StatefulWidget {
  const NuevaMeta({super.key});

  @override
  State<NuevaMeta> createState() => _NuevaMetaState();
}

class _NuevaMetaState extends State<NuevaMeta> {
  final fuenteAhorro = TextEditingController();
  final nombreAhorro = TextEditingController();
  final montoAhorro = TextEditingController();



  DateTime? fechaSeleccionada;

  

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


  void _guardarAhorroFireBase(Map<String, dynamic> data) async {
    try {
      
       // Obtener el usuario actualmente autenticado
      User? user = FirebaseAuth.instance.currentUser;

     
    if (user != null) {
        CollectionReference testCollection = FirebaseFirestore.instance.collection("Ahorros");

      DateTime now = DateTime.now();
      // Convierte el valor del campo 'Monto' a un entero
      int monto = int.tryParse(montoAhorro.text) ?? 0;
      //int progresoInicial = 
      
      data['IdUsuario'] = user.uid;
      await testCollection.add(data);
      print("Egreso agregado exitosamente");
    }else{

    }
    } catch (e) {
      print("Error al agregar el egreso: $e");
    }
  }

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

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.grey,
          ),
          elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Armemos tu meta de ahorro',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                '¿Que nombre le quieres dar a tu meta?',
                style: TextStyle(color: Colors.grey.shade800),
              ),
            ),
            TextField(
              controller: nombreAhorro,
                decoration: InputDecoration(
              hintText: 'Nombre de tu meta', // Customized hint text
              border: OutlineInputBorder(
                // Customized border
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 15, 182, 138)),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 15),
              child: Text(
                '¿Cuanto dinero necesitas para lograr tu meta?',
                style: TextStyle(color: Colors.grey.shade800),
              ),
            ),
            TextField(
              controller: montoAhorro,
                decoration: InputDecoration(
              hintText: r'$0.00', // Customized hint text
              border: OutlineInputBorder(
                // Customized border
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 15, 182, 138),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 15),
              child: Text('¿Donde tendrás el dinero de tu menta?',
                  style: TextStyle(color: Colors.grey.shade800)),
            ),
            TextField(
              controller: fuenteAhorro,
                decoration: InputDecoration(
              hintText: 'Cuenta BBVA', // Customized hint text
              border: OutlineInputBorder(
                // Customized border
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 15, 182, 138),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 15),
              child: Text('¿Para cuándo necesitas cumplir con esa meta?',
                  style: TextStyle(color: Colors.grey.shade800)),
            ),
            TextField(
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
              controller: TextEditingController(
                text: fechaSeleccionada != null
                    ? "${fechaSeleccionada!.day} ${monthsOfYear[fechaSeleccionada!.month - 1]} ${fechaSeleccionada!.year}"
                    : "Selecciona una fecha",
              ),
                decoration: InputDecoration(
                  hintText:
                      '${date.day} ${monthsOfYear[date.month]} ${date.year}', // Customized hint text
                  border: OutlineInputBorder(
                    // Customized border
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 15, 182, 138),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    int monto = int.tryParse(montoAhorro.text) ?? 0; 
                    Map<String, dynamic> data = {
                                'Monto': monto,
                                'Fecha': fechaSeleccionada != null
                                    ? Timestamp.fromDate(fechaSeleccionada!)
                                    : Timestamp.fromDate(DateTime.now()),
                                'Nombre': nombreAhorro.text,
                                'Fuente': fuenteAhorro.text,
                                "Progreso": 5.0
                              };
                    Navigator.pop(context
                    //Ahorro(nombre: nombre, meta: meta, origen: origen, fecha: fecha, progreso: progreso, IdUsuario: IdUsuario)
                   
                    
                    );
                    _guardarAhorroFireBase(data);
                  },
                  child: Text(
                    'Hecho',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(16.0),
                    backgroundColor: Color.fromARGB(255, 15, 182, 138),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
