import 'package:addhills_app/PAGE/home.dart';
import 'package:addhills_app/PAGE/login_page.dart';
import 'package:addhills_app/utils/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{

   Future<void> signUp({
    required String lastName,
    required String firstName,
    required String email,
    required String phoneNumber,
    required String address,
    required String birthday,
    required String password,
    required BuildContext context,
  }) async {
    
    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage()
        )
      );
      
    } on FirebaseAuthException catch(e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      debugPrint(message);
      //showSnackBar(context, message);
    }
    catch(e){

    }

  }


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

  


    Future<void> signin({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomePage()
        )
      );
      
    } on FirebaseAuthException catch(e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
       //showSnackBar(context, e.message!);
    }
    catch(e){

    }

  }

}