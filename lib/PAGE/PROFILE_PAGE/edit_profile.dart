//  import 'package:flutter/material.dart';

//  class EditProfile extends StatelessWidget {
//   var height,width;
//   //const EditProfile({super.key});
  
//   static const TextStyle genTextStyle = TextStyle(
//     color: Colors.black,
//     //fontWeight: FontWeight.bold,
//     fontSize: 15,  
//   );

//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;


//     return Scaffold(
//       appBar: AppBar(title: Center(child: Text('Edit Profile'))),
//       body: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.account_circle,
//                 color: Colors.black,
//                 size: width * .4,
//               ),             
//               Divider(
//                 indent: 20,
//                 endIndent: 20,
//                 color: Colors.black54
//               ),
//               Container(
//                 padding: EdgeInsets.only(
//                   left: 15,
//                   right: 15,
//                 ),
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   children: [
//                     SizedBox(height: 5),
//                     Container(
//                       padding: EdgeInsets.zero,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                       ),
//                       child: ListTile(
//                         dense: true,
//                         title: Text('First Name: ', style: genTextStyle,),
//                         trailing: Icon(Icons.edit),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black)
//                       ),
//                       child: ListTile(
//                         dense: true,
//                         title: Text('Last Name: ', style: genTextStyle,),
//                         trailing: Icon(Icons.edit),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black)
//                       ),
//                       child: ListTile(
//                         dense: true,
//                         title: Text('Phone Number: ', style: genTextStyle,),
//                         trailing: Icon(Icons.edit),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black)
//                       ),
//                       child: ListTile(
//                         dense: true,
//                         title: Text('Address: ', style: genTextStyle,),
//                         trailing: Icon(Icons.edit),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black)
//                       ),
//                       child: ListTile(
//                         dense: true,
//                         title: Text('Birthday: ', style: genTextStyle,),
//                         trailing: Icon(Icons.edit),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black)
//                       ),
//                       child: ListTile(
//                         dense: true,
//                         title: Text('Email: ', style: genTextStyle,),
//                         trailing: Icon(Icons.edit),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }