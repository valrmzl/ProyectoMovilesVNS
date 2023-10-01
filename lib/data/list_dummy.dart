
import 'package:flutter/material.dart';
import 'package:proyecto_vsn/data/dummy.dart';
List<money> geter(){
  money dad= money();
  dad.concepto = 'dinero papá';
  dad.fecha = "30/Sept/2023";
  dad.fee = '650';
  dad.icono =Icons.credit_score_outlined;
  return [dad];
}


 