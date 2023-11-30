import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
  
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay; // Agrega una variable para el día seleccionado
  DateTime? get selectedDayValue => selectedDay;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TableCalendar(
        firstDay: DateTime.utc(2022, 01, 01),
        lastDay: DateTime.utc(2032, 01, 01),
        focusedDay: DateTime.now(),
        headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(
              fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold),
        ),
        selectedDayPredicate: (DateTime day) {
          // Personaliza el color del día seleccionado aquí
          return isSameDay(selectedDay,
              day); // Cambia el color solo para el día seleccionado
        },
        onDaySelected: (selected, focused) {
          setState(() {
            selectedDay = selected; // Actualiza el día seleccionado
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: selectedDay != null
                ? Colors.blue
                : Colors
                    .transparent, // Cambia el color del día seleccionado aquí
            shape: BoxShape.circle, // Opcional: puedes personalizar la forma
          ),
          selectedTextStyle: TextStyle(
            color: Colors
                .white, // Opcional: cambia el color del texto en el día seleccionado
          ),
        ),
      ),
    );
  }
}
