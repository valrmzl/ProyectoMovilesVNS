import 'package:flutter/material.dart';

class NuevaMeta extends StatefulWidget {
  const NuevaMeta({super.key});

  @override
  State<NuevaMeta> createState() => _NuevaMetaState();
}

class _NuevaMetaState extends State<NuevaMeta> {
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
              height: MediaQuery.of(context).size.height * 0.2,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                '¿Cuanto dinero necesitas para lograr tu meta?',
                style: TextStyle(color: Colors.grey.shade800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text('¿Donde tendrás el dinero de tu menta?',
                  style: TextStyle(color: Colors.grey.shade800)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text('¿Para cuándo necesitas cumplir con esa meta?',
                  style: TextStyle(color: Colors.grey.shade800)),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Hecho'))
          ],
        ),
      ),
    );
  }
}
