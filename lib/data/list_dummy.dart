
import 'package:flutter/material.dart';
import 'package:proyecto_vsn/data/dummy.dart';
List<money> geter(){
  money dad= money();
  dad.concepto = 'dinero papá';
  dad.fecha = "30/Sept/2023";
  dad.fee = '650';
  dad.icono =Icons.credit_score_outlined;
  dad.tipo=true;


  money cafe= money();
  cafe.concepto = 'cafe starbucks';
  cafe.fecha = "30/Sept/2023";
  cafe.fee = '80';
  cafe.icono =Icons.credit_score_outlined;
  cafe.tipo=false;
  return [dad,cafe, dad, cafe, dad, cafe, dad, cafe, dad, cafe];
}


 