// import 'package:addhills_app/MODELS/Requests/venue_request_model.dart';
// import 'package:addhills_app/SERVICES/db_service.dart';
// import 'package:addhills_app/utils/methods.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarDatepicker extends StatefulWidget {
//   const CalendarDatepicker({super.key});

//   @override
//   State<CalendarDatepicker> createState() => _CalendarDatepickerState();
// }

// class _CalendarDatepickerState extends State<CalendarDatepicker> {
//   late DateTime _selectedDay;
//   late DateTime _focusedDay;
//   Map<DateTime, List<Map<String, String>>> _events = {};
//   final DbService _dbService = DbService();

//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = DateTime.now();
//     _focusedDay = DateTime.now();

//     fetchEvents();
//   }

//   void fetchEvents() {
//     try {
//       _dbService.getVenueReqs().listen((snapshot) {
//         final Map<DateTime, List<Map<String, String>>> loadedEvents = {};

//         for (var doc in snapshot.docs) {
//           VenueRequestModel data = doc.data(); // Assuming this returns VenueRequestModel
//           DateTime date = DateTime.parse(data.selected_date);
//           String event = data.venue_name;
//           String startTime = data.start_time;
//           String endTime = data.end_time;

//           if (loadedEvents[date] == null) {
//             loadedEvents[date] = [];
//           }
//           loadedEvents[date]!.add({
//             'event': event,
//             'start_time': startTime,
//             'end_time': endTime,
//           });
//         }

//         setState(() {
//           _events = loadedEvents;
//         });
//       });
//     } catch (e) {
//       print('Error fetching events: $e');
//     }
//   }

//    List<Map<String, String>> getEventsForDay(DateTime date) {
//     return _events[date] ?? [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('Select Date')),
//       ),
//       body: Column(
//         children: [
//           TableCalendar(
//             focusedDay: _focusedDay,
//             selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//             onDaySelected: (selectedDay, focusedDay) {
//               setState(() {
//                 _selectedDay = selectedDay;
//                 _focusedDay = focusedDay;
//               });
//             },
//             firstDay: DateTime.utc(2020, 1, 1),
//             lastDay: DateTime.utc(2030, 12, 31),
//             headerStyle: HeaderStyle(
//               titleCentered: true,
//               formatButtonVisible: false,
//             ),
//             calendarStyle: CalendarStyle(
//               selectedDecoration: BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//               markerDecoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             calendarBuilders: CalendarBuilders(
//               markerBuilder: (context, date, events) {
//                 if (getEventsForDay(date).isNotEmpty) {
//                   return Positioned(
//                     bottom: 1,
//                     child: Icon(
//                       Icons.event,
//                       color: Colors.red,
//                       size: 16,
//                     ),
//                   );
//                 }
//                 return null;
//               },
//             ),
//           ),
//           // SizedBox(height: 20),
//           // Text(
//           //   'Selected day: ${formatDate(_selectedDay)}',
//           //   style: TextStyle(fontSize: 16),
//           // ),
//           SizedBox(height: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: getEventsForDay(_selectedDay).map((event) {
//               return Text(
//                 '${event['event']} - ${event['start_time']} to ${event['end_time']}',
//                 style: TextStyle(fontSize: 16),
//               );
//             }).toList(),
//           ),
//           // SizedBox(height: 20),
//           // ElevatedButton(
//           //   onPressed: () {
//           //     //Navigator.pop(context, _selectedDay);
//           //     print(formatDate(_selectedDay));
//           //   },
//           //   child: Text('Confirm Date'),
//           // ),
//         ],
//       ),
//     );
//   }
// }





// //ERRORERRORERRORERRORERRORERRORERRORERRORERRORERRORERROR



import 'package:addhills_app/MODELS/Requests/venue_request_model.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:addhills_app/utils/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

class VenueCalendarPage extends StatefulWidget {
  final String venueName;  // Add venueName parameter

  const VenueCalendarPage({super.key, required this.venueName});  // Update constructor

  @override
  State<VenueCalendarPage> createState() => _VenueCalendarPageState();
}

class _VenueCalendarPageState extends State<VenueCalendarPage> {
  final DbService _dbService = DbService();
  List<CalendarEventData> _events = [];
  final GlobalKey<MonthViewState> _calendarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadEvents();  // Directly load events based on the venue name
  }

  void loadEvents() {
    _dbService.getVenueReqs().listen((snapshot) {
      List<CalendarEventData> events = snapshot.docs.map((doc) {
        VenueRequestModel data = doc.data();
        DateTime selectedDate = DateTime.parse(data.selected_date);
        
        // Filter events based on the venue name passed to this page
        if (data.venue_name == widget.venueName) {
          DateTime startTime = _convertToDateTime(selectedDate, data.start_time);
          DateTime endTime = _convertToDateTime(selectedDate, data.end_time);

          return CalendarEventData(
            date: selectedDate,
            startTime: startTime,
            endTime: endTime,
            title: data.venue_name,
            description: doc.id,
          );
        } else {
          return null; // Exclude events that do not match the venue name
        }
      }).whereType<CalendarEventData>().toList();  // Filter out null values

      setState(() {
        _events = events;
      });
      _calendarKey.currentState?.controller.addAll(_events);
    });
  }

  DateTime _convertToDateTime(DateTime date, String time) {
    final timeParts = time.split(' ');
    final hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);

    if (timeParts[1] == 'PM' && hour != 12) {
      hour += 12;
    } else if (timeParts[1] == 'AM' && hour == 12) {
      hour = 0;
    }

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Select Date for ${widget.venueName}'))),
      body: Column(
        children: [
          Expanded(
            child: CalendarControllerProvider(
              controller: EventController()..addAll(_events),
              key: _calendarKey,
              child: MonthView(
                onCellTap: (events, date) {
                  final now = DateTime.now();
                  final pastDaysFromNow = now.subtract(Duration(days: 1));
                  final threeDaysFromNow = now.add(Duration(days: 3));

                  if (date.isBefore(pastDaysFromNow)) {
                    // If the date is in the past
                    showSnackBar(context, 'Past dates cannot be selected.');
                  } else if (date.isBefore(threeDaysFromNow)) {
                    // If the date is within the next 3 days
                    showSnackBar(context, 'You can only select dates after ${threeDaysFromNow.toLocal().toString().split(' ')[0]}.');
                  } else {
                    // Handle valid date selection
                    debugPrint('Date tapped: $date');
                    Navigator.pop(context, date);  // Return the selected date
                  }
                },
                onEventTap: (event, date) {
                  // Handle event tap (optional)
                  debugPrint('Event tapped: ${event.title}');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

