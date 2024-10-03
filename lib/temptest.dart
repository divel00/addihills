
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDatepicker extends StatefulWidget {
  const CalendarDatepicker({super.key});

  @override
  State<CalendarDatepicker> createState() => _CalendarDatepickerState();
}

class _CalendarDatepickerState extends State<CalendarDatepicker> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  Map<DateTime, List<Map<String, String>>> _events = {
    DateTime.utc(2024, 9, 25): [
      {
        'event': 'Meeting with team',
        'start_time': '10:00 AM',
        'end_time': '11:00 AM',
      },
      {
        'event': 'Doctor Appointment',
        'start_time': '2:00 PM',
        'end_time': '3:00 PM',
      },
    ],
    DateTime.utc(2024, 9, 26): [
      {
        'event': 'Project Deadline',
        'start_time': '5:00 PM',
        'end_time': '5:30 PM',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  List<Map<String, String>> getEventsForDay(DateTime date) {
    return _events[date] ?? [];
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Select Date')),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (getEventsForDay(date).isNotEmpty) {
                  return Positioned(
                    bottom: 1,
                    child: Icon(
                      Icons.event,
                      color: Colors.red,
                      size: 16,
                    ),
                  );
                }
                return SizedBox(); // Return an empty widget if no events
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Selected day: ${formatDate(_selectedDay)}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getEventsForDay(_selectedDay).isNotEmpty
                ? getEventsForDay(_selectedDay).map((event) {
                    return Text(
                      '${event['event']} - ${event['start_time']} to ${event['end_time']}',
                      style: TextStyle(fontSize: 16),
                    );
                  }).toList()
                : [Text('No events for this day.')],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print('Confirmed Date: ${formatDate(_selectedDay)}');
              // Here you could navigate back or do something else
            },
            child: Text('Confirm Date'),
          ),
        ],
      ),
    );
  }
}
