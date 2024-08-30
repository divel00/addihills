import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

Future<bool> showConfirmationDialog(BuildContext context) async {
// Show the dialog
  final bool? result = await showDialog<bool>(
    context: context,
    barrierDismissible: false, // Prevents closing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Submission'),
        content: Text('Are you sure you want to submit this request?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User clicked Cancel
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // User clicked Confirm
            },
            child: Text('Confirm'),
          ),
        ],
      );
    },
  );

  // Ensure that a non-null boolean value is returned
  return result ?? false;
}

// DateTime parseDate(String dateString) {
//     try {
//       return DateFormat('yyyy-MM-dd').parse(dateString);
//     } catch (e) {
//       // Handle parse error if needed
//       throw FormatException('Invalid date format');
//     }
//   }


// String calculateAge(DateTime birthDate) {
//   final now = DateTime.now();
//   int age = now.year - birthDate.year;

//   if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
//     age--;
//   }

//   return age as String;
// }


String calculateAge(String dateString) {
  // Parse the date string into a DateTime object
  final DateTime birthDate = DateFormat('yyyy-MM-dd').parse(dateString);
  
  // Calculate age
  final now = DateTime.now();
  int age = now.year - birthDate.year;
  if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }

  return age.toString();

}

String calculateYearsAndMonthsOfResidence(String dateString) {
  // Parse the date string to DateTime
  DateTime residenceDateTime = DateTime.parse(dateString);

  // Get the current date
  DateTime now = DateTime.now();

  // Calculate the difference in years and months
  int years = now.year - residenceDateTime.year;
  int months = now.month - residenceDateTime.month;

  // Adjust for negative months
  if (months < 0) {
    years--;
    months += 12;
  }

  // Return formatted result
  return '${years} years, ${months} months';
}


//ID generator
String generateTimestampBasedId() {
  final int timestamp = DateTime.now().millisecondsSinceEpoch;
  final int randomPart = Random().nextInt(1000000);  // Random number to ensure uniqueness
  return '$timestamp-$randomPart';
}

Timestamp addtimestamp(){
    Timestamp now = Timestamp.now();
    // Convert Timestamp to DateTime
    DateTime nowDateTime = now.toDate();
    // Add 6 days to the current DateTime
    DateTime futureDateTime = nowDateTime.add(Duration(days: 6));
    // Convert the future DateTime back to Firestore Timestamp
    Timestamp futureTimestamp = Timestamp.fromDate(futureDateTime);

  return futureTimestamp;
}

// Method to convert Timestamp to a formatted DateTime string
String convertTimestampToString(Timestamp timestamp) {
  // Convert Timestamp to DateTime
  DateTime dateTime = timestamp.toDate();

  // Define the format you want
  DateFormat formatter = DateFormat('yyyy-MM-dd'); // Example format

  // Format the DateTime object
  String formattedDate = formatter.format(dateTime);

  return formattedDate;
}