// import 'package:addhills_app/PAGE/home.dart';
// import 'package:addhills_app/PAGE/login_page.dart';
// import 'package:addhills_app/utils/show_snackbar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthService{

//   Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

//    Future<void> signUp({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
    
//     try {

//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password
//       );

//       await Future.delayed(const Duration(seconds: 1));
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => LoginPage()
//         )
//       );
      
//     } on FirebaseAuthException catch(e) {
//       String message = '';
//       if (e.code == 'weak-password') {
//         message = 'The password provided is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         message = 'An account already exists with that email.';
//       }
//       debugPrint(message);
//       showSnackBar(context, message);
//     }
//     catch(e){

//     }

//   }




  


//     Future<void> signin({
//     required String email,
//     required String password,
//     required BuildContext context
//   }) async {
    
//     try {

//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password
//       );

//       await Future.delayed(const Duration(seconds: 1));
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) => const HomePage()
//         )
//       );
      
//     } on FirebaseAuthException catch(e) {
//       String message = '';
//       if (e.code == 'invalid-email' || e.code == 'invalid-credential') {
//         showSnackBar(context, 'The email address or password you entered is incorrect. Please try again.');
//       }
       
//     }
//     catch(e){

//     }

//   }

// }



  // final FirebaseAuth _auth;
  // AuthService(this._auth);
  
  // Future<void> signUp({
  //   required String lastName,
  //   required String firstName,
  //   required String email,
  //   required String phoneNumber,
  //   required String address,
  //   required String birthday,
  //   required String password,
  //   required BuildContext context,
  // }) async {  
  //   try{
  //     await _auth.createUserWithEmailAndPassword(
  //       email: email, 
  //       password: password);
  //   } on FirebaseAuthException catch (e){
  //     showSnackBar(context, e.message!);
  //     debugPrint(e.message!);
  //   }
  // }