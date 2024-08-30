import 'package:addhills_app/MODELS/venues.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/venue_content.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_navigationpop.dart';
import 'package:addhills_app/PAGE/chat_dialog.dart';

class VenueReservationPage extends StatelessWidget{
  VenueReservationPage({super.key});
  static var height,width;

  @override
  Widget build(BuildContext context){
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
                              'Venue Reservation',
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
                          ListOfVenues(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const MessageDialog();
            },
          );
        },
        backgroundColor: Color(0xFF3D3D3D),
        foregroundColor: Colors.white,
        child: Icon(Icons.chat),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class ListOfVenues extends StatelessWidget {
  // const ListOfDoc({
  //   super.key,
  //   required this.height,
  //   required this.width,
  // });

  var height = VenueReservationPage.height;
  var width = VenueReservationPage.width;

  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height * .67), width: width,
      padding: EdgeInsets.only(left: 50, right: 50),
      child: StreamBuilder(
        stream: _dbService.getVenues(),
        builder: (context, snapshot) {
          List docs = snapshot.data?.docs?? [];
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Venues docu = docs[index].data();
              return ListTile(
                title: Container(
                  //padding: EdgeInsets.only(top: 50),
                  //alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${docu.venueName}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('${docu.venueDescription}', style: TextStyle(fontSize: 15), maxLines: 3,overflow: TextOverflow.ellipsis,),
                      Text('see more...', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      Divider(
                        color: Colors.black54
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                  context, MaterialPageRoute(builder: (BuildContext context) => VenueContent(
                    name: '${docu.venueName}', 
                    description: '${docu.venueDescription}',
                    lastMod: '${docu.lastUpdatedOn}',
                    CreatedOn: '${docu.createdOn}',
                    requirement: '- ${docu.venueRequirements.join('\n- ')}',
                    available: '- ${docu.venueAvailable.join('\n- ')}',
                    price: '${docu.venuePrice}', 
                    address: '${docu.venueAddress}',
                  )));
                },
              );
            },
          );
        }
      ),
    );
  }
}