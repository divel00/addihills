import 'package:flutter/material.dart';

class TopNavigationpop extends StatelessWidget {
  //const TopNavigationpop({super.key});
  final Color color;

  TopNavigationpop({required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20,top: 70),
          child: IconButton(
            iconSize: 35,
            icon: Icon(
              Icons.arrow_back,
              color: color),
            onPressed: (){
              Navigator.pop(context);
            },          
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 70),
          child: Text('LogoName', style: TextStyle(color:color, fontSize: 35),),
        ),
      ],
    );
  }
}

