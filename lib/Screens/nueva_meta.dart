import 'package:flutter/material.dart';

class NuevaMeta extends StatefulWidget {
  const NuevaMeta({super.key});

  @override
  State<NuevaMeta> createState() => _NuevaMetaState();
}

class _NuevaMetaState extends State<NuevaMeta> {
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
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      // Actualizar el valor del campo con la fecha seleccionada
                      // Puedes usar el controlador del campo para hacerlo
                      // Ejemplo: _textController.text = selectedDate.toLocal().toString();
                    }
                  });
                },
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
                    Navigator.pop(context);
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
