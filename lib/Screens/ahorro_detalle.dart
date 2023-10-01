import 'package:flutter/material.dart';
import 'package:proyecto_vsn/Screens/agregar_dinero_ahorro.dart';

import 'ahorros.dart';

class AhorroDetalle extends StatefulWidget {
  final Ahorro data;

  const AhorroDetalle({Key? key, required this.data}) : super(key: key);

  @override
  State<AhorroDetalle> createState() => _AhorroDetalleState();
}

class _AhorroDetalleState extends State<AhorroDetalle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AgregarDineroAhorro()),
                  );
                },
                child: Text('+ Agregar dinero',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.grey,
            ),
            elevation: 0),
        body: Text(widget.data.nombre));
  }
}
