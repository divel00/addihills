import 'package:addhills_app/MODELS/announcements.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:addhills_app/utils/announcement_page.dart';
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
                    Divider(
                      indent: 40,
                      endIndent: 40,
                      color: Colors.white,
                      thickness: 2,
                    ),
                    Container(
                      //width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .4,
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
  static var height,width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
      // decoration: BoxDecoration(
      //   border: Border(
      //     top: BorderSide(color: Colors.white70, width: 1),
      //   ),
      // ),
      child: StreamBuilder(
        stream: _dbService.getAnnouncements(),
        builder: (context, snapshot) {
          List docs = snapshot.data?.docs ?? [];
          return Container(
            height: 150, // Set height for the horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                Announcements docu = docs[index].data();
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (BuildContext context) => AnnouncementPage(
                        imageUrl: docu.imageUrl, 
                        title: docu.title, 
                        content: docu.content, 
                        published_date: convertTimestampToString(docu.published_date))));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[400], // Adjust the color as needed
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    width: width * .9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * .3, 
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              docu.imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          alignment: Alignment.center,
                          height: (height * .3) * .15, 
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            docu.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${convertTimestampToString(docu.published_date)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
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