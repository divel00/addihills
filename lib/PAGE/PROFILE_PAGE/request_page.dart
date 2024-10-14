import 'package:addhills_app/MODELS/Requests/docu_request.dart';
import 'package:addhills_app/MODELS/Requests/equips_request_model.dart';
import 'package:addhills_app/MODELS/Requests/venue_request_model.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:addhills_app/utils/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Requests', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerForTfield(text: 'Date \nRequested'),
                headerForTfield(text: 'Transaction'),
                headerForTfield(text: 'Status'),
              ],
            ),
          ),
          SizedBox(height: 8),
          Divider(height: 0, color: Colors.black54),
          Expanded(child: CombinedRequestsList()), // New combined widget
        ],
      ),
    );
  }
}

class CombinedRequestsList extends StatelessWidget {
  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    // Get current user email for fetching requests
    final String? currentUserEmail = getCurrentUserEmail(); // Replace this with the actual current user's email

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _dbService.getAllUserRequests(currentUserEmail!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<Map<String, dynamic>> allRequests = snapshot.data ?? [];

        if (allRequests.isEmpty) {
          return Center(child: Text('No requests found.', style: TextStyle(fontSize: 20, color: Colors.black)));
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: allRequests.length,
          itemBuilder: (context, index) {
            final request = allRequests[index];
            final requestData = request['data'];
            String dateRequested = DateFormat('yyyy-MM-dd').format(requestData.date_requested.toDate());
            String status = requestData.request_status;

            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dateRequested, style: TextStyle(fontSize: 13)),
                      SizedBox(width: 10),
                      Container(
                        width: MediaQuery.of(context).size.width * .39,
                        child: Text(
                          request['type'] == 'Document Request'
                              ? (requestData as DocuRequest).document_title
                              : request['type'] == 'Venue Request'
                                  ? (requestData as VenueRequestModel).venue_name
                                  : 'Equipments', // Changed this line to display "Equipments"
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                          softWrap: true,
                        ),
                      ),
                      Text(status, style: TextStyle(fontSize: 13), textAlign: TextAlign.center),
                    ],
                  ),
                  Divider(color: Colors.black54),
                ],
              ),
            );
          },
        );
      },
    );
  }
}


class headerForTfield extends StatelessWidget {
  final String text;
  headerForTfield({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      alignment: Alignment.topLeft,
      child: Text('$text', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }
}
