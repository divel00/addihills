



import 'package:addhills_app/MODELS/docu_request.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20,top: 70),
                child: IconButton(
                  iconSize: 35,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black),
                  onPressed: (){
                    Navigator.pop(context);
                  },          
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(top: 70),
                child: Text('LogoName', style: TextStyle(color: Colors.black, fontSize: 35),),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications, size: 35,),
                Container(
                  child: Text('Request', style: TextStyle(color: Colors.black, fontSize: 25),),
                ),
              ],
            ),
          ),
          Divider(
            indent: 30,
            endIndent: 30,
            color: Colors.black54
          ),
          listOfReq()
        ],
      ),
    );
  }
}

class listOfReq extends StatelessWidget {
  var height;
  var width;

  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context)  {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: (height * .67), width: width,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: StreamBuilder(
        stream: _dbService.getDocsReq(),
        builder: (context, snapshot) {
          List docsreq = snapshot.data?.docs?? [];
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: docsreq.length,
            itemBuilder: (context, index) {
              DocuRequest docu = docsreq[index].data();
              return ListTile(
                title: Container(
                  //padding: EdgeInsets.only(top: 50),
                  //alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                          
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${docu.document_title} ',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                                Text(DateFormat('yyyy-MM-dd h:mm a').format(docu.date_requested.toDate()), style: TextStyle(fontSize: 15),),
                              ],
                            ),
                          ),
                          Expanded(                            
                            child: Container(
                              alignment: Alignment.center,
                              child: Text('${docu.request_status}', 
                                style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                            color: Colors.black54
                          ),
                    ],
                  ),
                ),
                onTap: () {
                  _showDialog(context,docu.document_title,docu.date_requested,docu.request_status,docu.pickup_date);
                  // Navigator.push(
                  // context, MaterialPageRoute(builder: (BuildContext context) => DocReqPress(title: '${docu.title}', description: '${docu.description}',)));
                },
              );
            },
          );
        }
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, String title, Timestamp date, String status, Timestamp pickup_date) {
  String? temp;

  if (status == 'Approved'){
    temp = DateFormat('yyyy-MM-dd').format(pickup_date.toDate());
  }
  else{
    temp = '';
  }
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(16.0), // Adjust padding as needed
        content: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300), // Adjust width as needed
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.0), // Add spacing between widgets
              //Text('Created on: ',style: TextStyle(fontSize: 15),),
              Text('Created on: ${DateFormat('yyyy-MM-dd h:mm a').format(date.toDate())}',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 8.0), // Add spacing between widgets
              Text(
                'Status: $status',
                style: TextStyle(fontSize: 15),
                //textAlign: TextAlign.justify,
              ),
              SizedBox(height: 8.0), // Add spacing between widgets
              Text(
                'Pickup Date: $temp', style: TextStyle(fontSize: 15),),
            ],
          ),
        ),
      );
    },
  );
}
}


