import 'package:flutter/material.dart';

class AgregarDineroAhorro extends StatefulWidget {
  final String documentoId;

  const AgregarDineroAhorro({required this.documentoId, Key? key}) : super(key: key);

  @override
  State<AgregarDineroAhorro> createState() => _AgregarDineroAhorroState();
}

class _AgregarDineroAhorroState extends State<AgregarDineroAhorro> {
   @override
  void initState() {
    super.initState();
    
    // Imprimir el ID del documento en la consola
    print('ID del Documento: ${widget.documentoId}');
  }
   TextEditingController _amountController = TextEditingController();
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
                'Estás un paso más cerca de tu meta 🤑',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                '¿Cuanto dinero le agregarás a tu meta?',
                style: TextStyle(color: Colors.grey.shade800),
              ),
            ),
            TextField(
                decoration: InputDecoration(
              hintText: r'$0.00', // Customized hint text
              border: OutlineInputBorder(
                // Customized border
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 15, 182, 138)),
              ),
            )),
           
           
         
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Agregar dinero',
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
