import 'package:flutter/material.dart';

class AnnouncementPage extends StatelessWidget {
  String imageUrl,title,content,published_date;
  static var height,width;

  AnnouncementPage({
    required this.imageUrl,
    required this.title,
    required this.content,
    required this.published_date,
  });

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.bottomRight,
          child: Text(
            published_date, 
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: height * .3, 
                child: ClipRRect(
                  //borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: width, 
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[800],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.black,
                thickness: 1,
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: width,
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
          
            ],
          ),
        ],
      ),
    );
  }
}