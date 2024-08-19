import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/doc_req_press.dart';
import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/document_request.dart';
import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/dr_register.dart';
import 'package:addhills_app/PAGE/home.dart';
import 'package:addhills_app/PAGE/login_page.dart';
import 'package:addhills_app/PAGE/request_page.dart';
import 'package:addhills_app/PAGE/signup_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
FirebaseFirestore.instance.settings = const Settings(
  persistenceEnabled: true,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginPage(),
    );
  }
}
