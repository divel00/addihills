import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/doc_req_press.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_iconbuttons.dart';

class DocuPage extends StatelessWidget {
  //const DocuPage({super.key});
  var height,width;

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
                          Container(
                            height: (height * .67), width: width,
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Container(
                                    height: 135,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Document Request', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                                        Text('Lorem ipsum dolor sit amet, consectetur '
                                        'adipiscing elit, sed do eiusmod tempor incididunt ut labore' 
                                        'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
                                        'exercitation ullamco laboris nisi ut aliquip' 
                                        'ex ea commodo consequat. ', style: TextStyle(fontSize: 15), maxLines: 3,overflow: TextOverflow.ellipsis,),
                                        Text('see more...', style: TextStyle(fontSize: 13)),
                                        Divider(
                                          color: Colors.black54
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                    context, MaterialPageRoute(builder: (BuildContext context) => DocReqPress()));
                                  },
                                );
                              },
                            ),
                          )
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