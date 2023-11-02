import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_vsn/Screens/agregar_dinero_ahorro.dart';
import 'package:proyecto_vsn/theme/bloc/theme_bloc.dart';

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
        body: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      decoration: BoxDecoration(
                        color: themeState.themeData.colorScheme.primary,
                        borderRadius: BorderRadius.circular(
                            12), // Adjust the radius as needed
                      ),
                      child: Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(widget.data.nombre,
                            style: TextStyle(
                                fontSize: 17,
                                color: themeState.themeData.colorScheme.shadow,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text('Tu total ahorrado',
                              style: TextStyle(
                                fontSize: 15,
                                color: themeState.themeData.colorScheme.shadow,
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '\$${widget.data.progreso.toString()}',
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: Text('MXM',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color:
                                        themeState.themeData.colorScheme.shadow,
                                  )),
                            )
                          ],
                        ),
                        Text('Presupuesto',
                            style: TextStyle(
                              color: themeState.themeData.colorScheme.shadow,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, top: 10),
                          child: Container(
                            height: 8,
                            child: LinearProgressIndicator(
                              value: widget.data.progreso / widget.data.meta,
                              backgroundColor: Colors
                                  .grey.shade100, // Color de fondo de la barra
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 182, 179,
                                      196)), // Color de la parte de progreso
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "\$${widget.data.progreso}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text("\$${widget.data.meta}",
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
    //Center(child: Text(widget.data.nombre)));
  }
}
