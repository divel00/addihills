import 'package:addhills_app/MODELS/docu_request.dart';
import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/document_request.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/item_Map.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_navigationpop.dart';

class VenueRequest extends StatelessWidget {
  var height,width;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  String title;

  VenueRequest({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.black,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    height: height * 0.15,
                    width: width,
                    alignment: Alignment.topCenter,
                    child: TopNavigationpop(color: Colors.white,),
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          )
                        ),
                        height: height - (height * 0.15),
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                                bottom: 15,
                              ),
                              child: Text(
                                'Venue Request',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(
                              indent: 50,
                              endIndent: 50,
                              color: Colors.black54
                            ),
                            Container(
                              height: (height * .64), width: width,
                              padding: EdgeInsets.only(left: 50, right: 50),
                              child: VenueForm(controller1: _controller1, controller2: _controller2, controller3: _controller3, title: '$title',),
                            ),
                            VenueSubmit(title: title,controller1: _controller1, controller2: _controller2, controller3: _controller3,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

class VenueForm extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  String title;

  VenueForm({
    required this.controller1,
    required this.controller2,
    required this.controller3,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Text('$title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
        Container(
          padding: EdgeInsets.only(top: 8),
          alignment: Alignment.topLeft,
          child: Text( 'Please ensure that the provided information is valid and correct.', style: TextStyle(fontSize: 15, color: Colors.black), textAlign: TextAlign.justify,),
        ),      
        // headerForTfield(text: 'Name',),
        // buildName(),
        // headerForTfield(text: 'Address',),
        // buildAddress(),    
        // headerForTfield(text: 'Birthday',),
        // buildBirthday(),   
        headerForTfield(text: 'Purpose',),
        buildPurpose(),     
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Column(
            children: [
              Text(
                'Additional Requests',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ), 
              Divider(
                // indent: 50,
                // endIndent: 50,
                color: Colors.black54
              ),              
            ],
          ),
        ),
        //ItemMap(),
      ],
    );
  }

   Widget buildPurpose() => TextField(
    controller: controller1,
    style: TextStyle(fontSize: 15),
    decoration: InputDecoration(
      hintText: 'What Event? e.g. For a birthday party',
      border: OutlineInputBorder(),
      isDense: true,
      contentPadding: EdgeInsets.all(8),
    ),
    textInputAction: TextInputAction.done,
  );

}

class headerForTfield extends StatelessWidget {
  final String text;
  headerForTfield({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      alignment: Alignment.topLeft,
      child: Text('$text', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)));
  }
}

class VenueSubmit extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final String title;

  VenueSubmit({
    required this.title,
    required this.controller1,
    required this.controller2,
    required this.controller3,
  });

  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    Timestamp now = Timestamp.now();
    // Convert Timestamp to DateTime
    DateTime nowDateTime = now.toDate();
    // Add 6 days to the current DateTime
    DateTime futureDateTime = nowDateTime.add(Duration(days: 6));
    // Convert the future DateTime back to Firestore Timestamp
    Timestamp futureTimestamp = Timestamp.fromDate(futureDateTime);

    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 243, 109, 99),
          padding: EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10,),
        ),
        onPressed: (){
          DocuRequest docsreq = DocuRequest(
            document_title: title,
            requester_name: controller1.text, 
            address: controller2.text, 
            birthday: controller3.text, 
            request_status: "pending", 
            user_email: 'kungfupanda@email.com',
            date_requested: Timestamp.now(),
            pickup_date: futureTimestamp,
          );
          _dbService.addDocsReq(docsreq);
          
          //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DocuPage()));
          controller1.clear();
          controller2.clear();
          controller3.clear();

          _showDialog(context);
        },
        child: Text('Submit', style: TextStyle(fontSize: 15, color: Colors.white),),
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text('Request Submitted!'),
        );
      },
    );
  }
}




// ITEM TEMP________________________________________________________________________________________

