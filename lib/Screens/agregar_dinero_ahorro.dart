import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgregarDineroAhorro extends StatefulWidget {
  final String documentoId;

  const AgregarDineroAhorro({required this.documentoId, Key? key}) : super(key: key);

  @override
  State<AgregarDineroAhorro> createState() => _AgregarDineroAhorroState();
}

class _AgregarDineroAhorroState extends State<AgregarDineroAhorro> {
  final suma = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Imprimir el ID del documento en la consola
    print('ID del Documento: ${widget.documentoId}');
  }

  void actualizarCampo(String documentoId, int nuevoProgreso) async {
    try {
      // Obtener el valor actual de 'Progreso'
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Ahorros')
          .doc(documentoId)
          .get();

      int progresoActual = snapshot['Progreso'] ?? 0;

      // Sumar el valor existente y el nuevo valor introducido
      int progresoTotal = progresoActual + nuevoProgreso;

      // Actualizar el campo 'Progreso'
      await FirebaseFirestore.instance
          .collection('Ahorros')
          .doc(documentoId)
          .update({'Progreso': progresoTotal});

      print('Documento actualizado con éxito');
    } catch (e) {
      print('Error al actualizar el documento: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                  'Estás un paso más cerca de tu meta 🤑',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text('¿Cuánto dinero le agregarás a tu meta?',
                    style: TextStyle(color: Colors.grey.shade800)),
              ),
              TextField(
                controller: suma,
                decoration: InputDecoration(
                  hintText: r'$0.00', // Customized hint text
                  border: OutlineInputBorder(
                    // Customized border
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Color.fromARGB(255, 15, 182, 138)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      actualizarCampo(widget.documentoId, int.parse(suma.text));
                    },
                    child: Text(
                      'Agregar dinero',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
