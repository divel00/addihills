import 'package:addhills_app/MODELS/announcements.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:addhills_app/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_iconbuttons.dart';
import 'package:addhills_app/PAGE/chat_dialog.dart';
//import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 16, 16),
      drawer: const Menu(),
      body: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MenuNotifProfile(),
              const Padding(
                padding: EdgeInsets.only(
                  top: 80,
                  right: 80,
                ),
                child: Column(
                  children: [
                    Text(
                      'RequEase',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 40,
                        letterSpacing: 2,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.white38,
                            offset: Offset(3.0, 3.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  children: [
                    Text(
                      'Anouncement & Events',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white60,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .5,
                      // decoration: BoxDecoration(
                      //   color: Colors.grey[900],
                      // ),
                      child: Announcement(),
                    )
                    // SearchBar(
                    //   constraints: BoxConstraints(minHeight: 35),
                    //   leading: Icon(Icons.search),
                    // )
                  ],
                ),
              )
            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const MessageDialog(); // Show the chat dialog
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

class Announcement extends StatelessWidget {

  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white70, width: 1),
        ),
      ),
      child: StreamBuilder(
        stream: _dbService.getAnnouncements(),
        builder: (context, snapshot) {
          List docs = snapshot.data?.docs?? [];
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Announcements docu = docs[index].data();
              return ListTile(
                leading: Icon(Icons.notifications_rounded, color: Colors.white60,),
                title: Container(
                  //padding: EdgeInsets.only(top: 50),
                  //alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( docu.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white), maxLines: 2,overflow: TextOverflow.ellipsis,),
                      Text( '         ${convertTimestampToString(docu.published_date)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200, color: Colors.white)),
                      //Text('${docu.content}', style: TextStyle(fontSize: 13, color: Colors.white), maxLines: 2,overflow: TextOverflow.ellipsis, ),
                      //Text('see more...', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                      // Divider(
                      //   color: Colors.white70,
                      // ),
                    ],
                  ),
                ),
                onTap: () {
                  _showDialog(context, docu.title, docu.content);
                },
              );
            },
          );
        }
      ),
    );
  }
}

Future<dynamic> _showDialog(BuildContext context, String title, String content) {
    return showDialog(
      context: context,
      //barrierColor: Colors.white38, 
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
          // contentPadding: EdgeInsets.all(15),
          content: Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            width: double.maxFinite,
            height: 400,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(content, textAlign: TextAlign.justify, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 243, 109, 99)),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white)
              ),
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('Close')
            )
          ],
        );
      },
    );
  }