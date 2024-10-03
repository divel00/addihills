import 'package:addhills_app/PAGE/OTHER_SERVICES/EQUIPMENTS_PAGE/equipments_page.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/item_Map.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/venue_request.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/venue_reservation_page.dart';
import 'package:addhills_app/PAGE/PROFILE_PAGE/edit_profile.dart';
import 'package:addhills_app/SERVICES/auth_service.dart';
import 'package:addhills_app/utils/calendar_datepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        StreamProvider(create: (context) => context.read<AuthService>().authState,
        initialData: null,)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomePage();
    }
    return LoginPage();
  }
}

  