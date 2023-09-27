import 'package:flutter/material.dart';

class Ahorros extends StatelessWidget {
  const Ahorros({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ahorros'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}