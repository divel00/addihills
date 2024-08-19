import 'package:addhills_app/PAGE/home.dart';
import 'package:addhills_app/utils/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{

  //  Future<void> signUp({
  //   required String lastName,
  //   required String firstName,
  //   required String email,
  //   required String phoneNumber,
  //   required String address,
  //   required String birthday,
  //   required String password,
  //   required BuildContext context,
  // }) async {
    
  //   try {

  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password
  //     );

  //     await Future.delayed(const Duration(seconds: 1));
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => const HomePage()
  //       )
  //     );
      
  //   } on FirebaseAuthException catch(e) {
  //     String message = '';
  //     if (e.code == 'weak-password') {
  //       message = 'The password provided is too weak.';
  //     } else if (e.code == 'email-already-in-use') {
  //       message = 'An account already exists with that email.';
  //     }
  //     showSnackBar(context, message);
  //   }
  //   catch(e){

  //   }

  // }

  final FirebaseAuth _auth;

  AuthService(this._auth);

  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Attempt to create a user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Successfully signed up
      print("User signed up: ${userCredential.user?.uid}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up successful')),
      );

    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      String errorMessage = '';
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/Password accounts are not enabled. Enable them in the Firebase Console.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'An unexpected error occurred: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      debugPrint(e.message ?? 'An unknown error occurred');

    } catch (e) {
      // Handle any other types of errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred')),
      );
      debugPrint(e.toString());
    }
  }


  // final FirebaseAuth _auth;
  // AuthService(this._auth);
  
  // Future<void> signUp({
  //   // required String lastName,
  //   // required String firstName,
  //   required String email,
  //   // required String phoneNumber,
  //   // required String address,
  //   // required String birthday,
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
       showSnackBar(context, e.message!);
    }
    catch(e){

    }

  }

}