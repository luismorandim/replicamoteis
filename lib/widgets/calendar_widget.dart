import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final String selectedOption;
  final DateTime? selectedDate;
  final DateTime? selectedEndDate;
  final Function(DateTime, DateTime?) onDateSelected;

  CalendarWidget({
    required this.selectedOption,
    required this.selectedDate,
    required this.selectedEndDate,
    required this.onDateSelected,
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime today;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: 12 - (today.month - 1),
      itemBuilder: (context, index) {
        DateTime monthStart = DateTime(today.year, today.month + index, 1);
        DateTime lastDayOfMonth = DateTime(monthStart.year, monthStart.month + 1, 0);

        DateTime focusedDay = today.isAfter(monthStart) ? today : monthStart;
        DateTime firstDay = today.isAfter(monthStart) ? today : monthStart;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              "${_getMonthName(monthStart.month)} ${monthStart.year}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TableCalendar(
              firstDay: firstDay,
              lastDay: lastDayOfMonth,
              focusedDay: focusedDay,
              calendarFormat: CalendarFormat.month,
              availableGestures: AvailableGestures.none,
              headerVisible: false,
              selectedDayPredicate: (day) {
                if (widget.selectedOption == "Diárias") {
                  return widget.selectedDate != null &&
                      widget.selectedEndDate != null &&
                      day.isAfter(widget.selectedDate!.subtract(Duration(days: 1))) &&
                      day.isBefore(widget.selectedEndDate!.add(Duration(days: 1)));
                }
                return widget.selectedDate != null && isSameDay(day, widget.selectedDate);
              },
              onDaySelected: (selectedDay, _) {
                if (selectedDay.isBefore(today)) return;
                setState(() {
                  if (widget.selectedOption == "Diárias") {
                    if (widget.selectedDate == null) {
                      widget.onDateSelected(selectedDay, null);
                    } else if (widget.selectedEndDate == null || selectedDay.isBefore(widget.selectedDate!)) {
                      widget.onDateSelected(selectedDay, widget.selectedDate);
                    } else {
                      widget.onDateSelected(widget.selectedDate!, selectedDay);
                    }
                  } else {
                    widget.onDateSelected(selectedDay, null);
                  }
                });
              },
              daysOfWeekVisible: true,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                selectedDecoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
      "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
    ];
    return monthNames[month - 1];
  }
}
