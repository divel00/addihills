import 'package:addhills_app/utils/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/request_page.dart';
import 'package:provider/provider.dart';


class ProfileIcon extends StatelessWidget {
  //const DocuPage({super.key});
  var height,width;

  static const TextStyle genTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 18,  
);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.black,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      height: height * 0.30,
                      width: width,
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 70,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: IconButton(
                                    iconSize: 35,
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white),
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },          
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(
                                top: 20,
                              ),
                              child: Text(
                                'My Profile',
                                style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: .90,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )
                      ),
                      height: height - (height * 0.30),
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 100,
                            ),
                          ),
                          Divider(
                            indent: 50,
                            endIndent: 50,
                            color: Colors.black54
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 70,
                              right: 70,
                            ),
                            child: ProfileList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(
                    top: height * .20,
                  ),
                  child: CircleAvatar(
                    radius: width * .2,
                    backgroundColor: Colors.black,//const Color.fromARGB(255, 141, 195, 240),
                    //foregroundColor: Colors.black,
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                      size: width * .4,
                    ),
                    // Text (
                    //   'TEST',
                    //   style: TextStyle(fontSize: 40),
                    // ),
                  )
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class ProfileList extends StatelessWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: Colors.black),
              title: const Text('Edit Profile', style: ProfileIcon.genTextStyle,),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.key,
                color: Colors.black),
              title: const Text('Change Password', style: ProfileIcon.genTextStyle),
              onTap: () {
                
              },
            ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.notifications,
            //     color: Colors.black),
            //   title: const Text('Requests', style: ProfileIcon.genTextStyle),
            //   onTap: () {
            //     Navigator.push(
            //     context, MaterialPageRoute(builder: (BuildContext context) => RequestPage()));
            //   },
            // ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.black),
              title: const Text('Sign Out', style: ProfileIcon.genTextStyle),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                } on FirebaseAuthException catch (e) {
                  showSnackBar(context, e.message!); // Displaying the error message
                }
  
              },
            ),
          ],
        ),
      ],
    );
  }
}