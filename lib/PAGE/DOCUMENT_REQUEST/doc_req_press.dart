import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/dr_register.dart';
import 'package:flutter/material.dart';
// import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/doc_req_content.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_navigationpop.dart';

class DocReqPress extends StatelessWidget {
  var height,width;
  String title,description,lastMod,CreatedOn,price,requirement,imageUrl;


  DocReqPress({
    required this.title,
    required this.description,
    required this.lastMod,
    required this.CreatedOn,
    required this.price,
    required this.requirement,
    required this.imageUrl,
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
                            height: (height * .64), width: width,
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                DocReqContent(
                                  title: title, 
                                  description: description, 
                                  lastMod: lastMod, 
                                  CreatedOn: CreatedOn, 
                                  price: price, 
                                  requirement: requirement, 
                                  imageUrl: imageUrl,
                                ),
                              ],
                            ),
                          ),
                          DocReqButton(title: title,price: price),
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

class DocReqContent extends StatelessWidget {
  String title,description,lastMod,CreatedOn,price,requirement,imageUrl;

  DocReqContent({
    required this.title,
    required this.description,
    required this.lastMod,
    required this.CreatedOn,
    required this.price,
    required this.requirement,
    required this.imageUrl,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Text('$title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
        Container(
          padding: EdgeInsets.only(top: 10,),
          alignment: Alignment.topLeft,
          child: Text( 'Description: \n $description \n\nRequirements: \n${requirement} \n\nFee: $price', 
          style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,),
        ),
        ImageDialogButton(imageUrl: imageUrl,)
      ],
    );
  }
}

class ImageDialogButton extends StatefulWidget {
  final String? imageUrl;

  ImageDialogButton({Key? key, this.imageUrl}) : super(key: key);

  @override
  _ImageDialogButtonState createState() => _ImageDialogButtonState();
}

class _ImageDialogButtonState extends State<ImageDialogButton> {
  @override
  Widget build(BuildContext context) {
    return widget.imageUrl != null && widget.imageUrl!.isNotEmpty
        ? Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton.icon(
              icon: Icon(Icons.image), // Replace with your icon or image
              label: Text('Attachment'),
              onPressed: _showImageDialog,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, 
                backgroundColor: Colors.blue, // Text color
              ),
            ),
          )
        : SizedBox.shrink(); // Return an empty widget if no URL
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Image.network(widget.imageUrl!),
        );
      },
    );
  }
}

class DocReqButton extends StatelessWidget {
  //const DocReqButton({super.key,});
  String title;
  String price;

  DocReqButton({
    required this.title,
    required this.price,
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
            context, MaterialPageRoute(builder: (BuildContext context) => DrRegister(title: title,price: price)));
        },
        child: Text('Request', style: TextStyle(fontSize: 15, color: Colors.white),),
      ),
    );
  }
}