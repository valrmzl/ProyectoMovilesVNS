import 'package:flutter/material.dart';

class Gastos extends StatelessWidget {
  const Gastos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gastos'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}