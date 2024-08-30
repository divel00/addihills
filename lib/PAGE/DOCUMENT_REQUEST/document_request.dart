import 'package:addhills_app/MODELS/docs.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/doc_req_press.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_iconbuttons.dart';
import 'package:addhills_app/PAGE/chat_dialog.dart';

class DocuPage extends StatefulWidget {
  @override
  State<DocuPage> createState() => _DocuPageState();
}

class _DocuPageState extends State<DocuPage> {
  //const DocuPage({super.key});
  static var height,width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const Menu(),
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
                  height: height * 0.2,
                  width: width,
                  alignment: Alignment.topCenter,
                  child: MenuNotifProfile()
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
                      height: height - (height * 0.2),
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
                              'Document Request',
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
                          ListOfDoc()
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

class ListOfDoc extends StatelessWidget {
  // const ListOfDoc({
  //   super.key,
  //   required this.height,
  //   required this.width,
  // });

  var height = _DocuPageState.height;
  var width = _DocuPageState.width;

  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height * .67), width: width,
      padding: EdgeInsets.only(left: 50, right: 50),
      child: StreamBuilder(
        stream: _dbService.getDocs(),
        builder: (context, snapshot) {
          List docs = snapshot.data?.docs?? [];
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Docs docu = docs[index].data();
              return ListTile(
                title: Container(
                  //padding: EdgeInsets.only(top: 50),
                  //alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${docu.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('${docu.description}', style: TextStyle(fontSize: 15), maxLines: 3,overflow: TextOverflow.ellipsis,),
                      Text('see more...', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      Divider(
                        color: Colors.black54
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                  context, MaterialPageRoute(builder: (BuildContext context) => DocReqPress(
                    title: '${docu.title}', 
                    description: '${docu.description}',
                    lastMod: '${docu.lastModificationOn}',
                    CreatedOn: '${docu.createdOn}',
                    requirement: '- ${docu.docRequirements.join('\n- ')}',
                    price: '${docu.price}',
                    
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