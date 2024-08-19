import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_navigationpop.dart';

class VenueReservationPage extends StatelessWidget{
  VenueReservationPage({super.key});
  var height,width;

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