import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/dr_register.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/venue_request.dart';
import 'package:flutter/material.dart';
// import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/doc_req_content.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_navigationpop.dart';

class VenueContent extends StatelessWidget {
  var height,width;
  String name,description,lastMod,CreatedOn,price,requirement,address,available;


  VenueContent({
    required this.name,
    required this.description,
    required this.address,
    required this.lastMod,
    required this.CreatedOn,
    required this.price,
    required this.requirement,
    required this.available,
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
                              'Vanue Reservation',
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
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                VenueReqContent(
                                  name: name, 
                                  description: description, 
                                  lastMod: lastMod, 
                                  CreatedOn: CreatedOn, 
                                  price: price, 
                                  requirement: requirement,
                                  available: available,
                                  address: address,
                                ),
                              ],
                            ),
                          ),
                          VenueReqButton(title: name,),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class VenueReqContent extends StatelessWidget {
  String name,description,lastMod,CreatedOn,price,address,available,requirement;

  VenueReqContent({
    required this.name,
    required this.description,
    required this.address,
    required this.lastMod,
    required this.CreatedOn,
    required this.price,
    required this.requirement,
    required this.available,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Text('$name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
        Container(
          padding: EdgeInsets.only(top: 10,),
          alignment: Alignment.topLeft,
          child: Text( 'Address: $address\n\nDescription: \n $description\n\nOpen Hours: \n$available\n\nRequirements: \n${requirement} \n\nFee: $price', 
          style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,),
        ),            
      ],
    );
  }
}

class VenueReqButton extends StatelessWidget {
  //const DocReqButton({super.key,});
  String title;

  VenueReqButton({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 243, 109, 99),
          padding: EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10,),
        ),
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (BuildContext context) => VenueRequest(title: title,)));
        },
        child: Text('Request', style: TextStyle(fontSize: 15, color: Colors.white),),
      ),
    );
  }
}