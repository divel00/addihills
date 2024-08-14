import 'package:flutter/material.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20,top: 70),
                child: IconButton(
                  iconSize: 35,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black),
                  onPressed: (){
                    Navigator.pop(context);
                  },          
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(top: 70),
                child: Text('LogoName', style: TextStyle(color: Colors.black, fontSize: 35),),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notifications, size: 35,),
                Container(
                  child: Text('Request', style: TextStyle(color: Colors.black, fontSize: 25),),
                ),
              ],
            ),
          ),
          Divider(
            indent: 30,
            endIndent: 30,
            color: Colors.black54
          ),
          // Container(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     itemBuilder: (context, index) {
          //       return Card();
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}