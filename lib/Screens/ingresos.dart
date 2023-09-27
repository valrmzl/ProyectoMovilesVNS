import 'package:flutter/material.dart';

class Ingresos extends StatelessWidget {
  const Ingresos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ingresos'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}