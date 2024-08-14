import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/dr_register.dart';

class DocReqContent extends StatelessWidget {
  //const DocReqContent({super.key});

  final String tempText = 'Lorem ipsum dolor sit amet, consectetur '
          'adipiscing elit, sed do eiusmod tempor incididunt ut labore ' 
          'et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud '
          'exercitation ullamco laboris nisi ut aliquip ' 
          'ex ea commodo consequat. ';


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Text('Document Request', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black))),
        Container(
          padding: EdgeInsets.only(top: 10,),
          alignment: Alignment.topLeft,
          child: Text( 'Description: \n$tempText \n\nRequirements: \n$tempText ', style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,),
        ),            
      ],
    );
  }
}

class DocReqButton extends StatelessWidget {
  //const DocReqButton({super.key,});

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
            context, MaterialPageRoute(builder: (BuildContext context) => DrRegister()));
        },
        child: Text('Request', style: TextStyle(fontSize: 15, color: Colors.white),),
      ),
    );
  }
}