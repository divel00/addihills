import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/document_request.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/burial_space_registration_page.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/venue_reservation_page.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/EQUIPMENTS_PAGE/equipments_page.dart';
import 'package:addhills_app/PAGE/home.dart';
import 'package:addhills_app/PAGE/PROFILE_PAGE/my_profile.dart';
import 'package:addhills_app/PAGE/request_page.dart';

class MenuNotifProfile extends StatelessWidget {
  const MenuNotifProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 70,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
            ),
            child: IconButton(
              iconSize: 35,
              icon: const Icon(
                Icons.menu,
                color: Colors.white),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },          
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30,
            ),
            child: Row(
              children: [
                Wrap(
                  spacing: -20.0,
                  children: [
                    // IconButton(
                    //   iconSize: 35,
                    //   icon: const Icon(
                    //     Icons.notifications,
                    //     color: Colors.white),
                    //   onPressed: (){
                    //     Navigator.push(
                    //     context, MaterialPageRoute(builder: (BuildContext context) => RequestPage()));
                    //   },          
                    // ),
                    IconButton(
                      iconSize: 35,
                      icon: const Icon(
                        Icons.account_circle,
                        color: Colors.white),
                      onPressed: (){
                        Navigator.push(
                        context, MaterialPageRoute(builder: (BuildContext context) => ProfileIcon()));
                      },   
                    ),
                  ]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

static const TextStyle menuTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 15,  
);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,        
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 70,
                  left: 30,
                ),
                child: IconButton(
                  iconSize: 35,
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black),
                  onPressed: (){
                    Navigator.pop(context);
                  },          
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 35,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                        color: Colors.black),
                      title: const Text('Home',style: menuTextStyle),
                      onTap: () {
                        Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
                      },
                    ),

                    // ListTile(
                    //   leading: const Icon(
                    //     Icons.chat_bubble,
                    //     color: Colors.black,
                    //   ),
                    //   title: const Text('Inquiry Bot',style: menuTextStyle),
                    //   onTap: () {
                    //   },
                    // ),

                    ListTile(
                      leading: const Icon(
                        Icons.edit_document,
                        color: Colors.black,
                      ),
                      title: const Text('Document Request',style: menuTextStyle),
                      onTap: () {
                        print('test');
                        Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (BuildContext context) => DocuPage()));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 30,
                  right: 30,
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Other services',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      ),
                    const Divider(color: Colors.black54),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ListTile(
                          //   title: const Text('Burial Space Registration',style: menuTextStyle),
                          //   onTap: () {
                          //     Navigator.push(
                          //       context, MaterialPageRoute(builder: (BuildContext context) => BurialSpaceRegistrationPage()));
                          //   },
                          // ),
                          ListTile(
                            title: const Text('Venue Reservation',style: menuTextStyle),
                            onTap: () {
                              Navigator.push(
                                context, MaterialPageRoute(builder: (BuildContext context) => VenueReservationPage()));
                            },
                          ),
                          ListTile(
                            title: const Text('Equipments',style: menuTextStyle),
                            onTap: () {
                              Navigator.push(
                                context, MaterialPageRoute(builder: (BuildContext context) => EquipmentsPage()));
                            },
                          ),
                        ],
                      ),
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
}